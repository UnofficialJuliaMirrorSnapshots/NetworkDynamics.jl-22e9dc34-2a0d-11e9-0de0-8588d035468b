module Utilities

using NLsolve
using DifferentialEquations
using LinearAlgebra

export edge_sum!, edge_sum

@inline function edge_sum!(e_sum, e_s, e_d)
    @inbounds for e in e_s
        e_sum .-= e
    end
    @inbounds for e in e_d
        e_sum .+= e
    end
    nothing
end

export RootRhs

struct RootRhs
    rhs
    mpm
end
function (rr::RootRhs)(x)
    dx = similar(x)
    rr.rhs(dx, x, nothing, 0.)
    rr.mpm * dx .- dx
end

function RootRhs(of::ODEFunction)
    mm = of.mass_matrix
    @assert mm != nothing
    mpm = pinv(mm) * mm
    RootRhs(of.f, mpm)
end


export find_valid_ic

function find_valid_ic(of::ODEFunction, ic_guess)
    rr = RootRhs(of)
    nl_res = nlsolve(rr, ic_guess)
    if converged(nl_res) == true
        return nl_res.zero
    else
        println("Failed to find initial conditions on the constraint manifold!")
        println("Try running nlsolve with other options.")
    end
end


export syms_containing, idx_containing

function syms_containing(nd, str)
    [s for s in nd.syms if occursin(str, string(s))]
end

function idx_containing(nd, str)
    [i for (i, s) in enumerate(nd.syms) if occursin(str, string(s))]
end


end #module

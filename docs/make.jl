using Documenter
using PointerArithmetic

makedocs(
    sitename = "PointerArithmetic.jl",
    format = Documenter.HTML(),
    modules = [PointerArithmetic]
)

#deploydocs(
#    repo = "github.com/nickolasrm/PointerArithmetic.jl.git"
#)
using DiffEqNoiseProcess, DiffEqBase, Base.Test
f(t) = exp(t)

W = NoiseFunction(0.0,f)

dt = 0.1
calculate_step!(W,dt)

for i in 1:10
  accept_step!(W,dt)
end

@test sol(W.curt + W.dt)[1] - W.curW == W.dW

prob = NoiseProblem(W,(0.0,1.0))
sol = solve(prob;dt=0.1)

@test sol(W.curt + W.dt)[1] - W.curW == W.dW

	using Plots
	using DataFrames, CSV
	using Distributions, Random
	using Statistics
M =27


μ_weight = [10  6  6  9  2  3  8  5  8  3  5  4  2  5  3  7  5  5  2  3  6  10  4  5  5  4  2 ]
σ_weight = fill(2,27)
a = [4 3 2 2 2 3 4 2 2 4 4 3 2 2 3 4 4 2 3 2 4 3 3 2 3 3 4]
b = [5 5 5 5 5 4 1 5 5 5 2 1 2 5 5 5 5 5 5 5 2 5 5 5 1 2 3]
c = [4 1 5 1 1 2 1 3 5 1 1 1 1 2 1 3 3 5 5 5 1 2 3 1 2 2 3]
UB = fill(5 , M)
e = [hcat(a',UB) , hcat(b',UB) , hcat(c',UB)] 
q = fill(0,M)
p = fill(4,M);

function f_weight(μ_weight , σ_weight)
     l =   rand.([Normal(μ_weight[j] , σ_weight[j]) for j in 1:M] )
    return l
end

function f_d(e)
    d = fill(0.0, M)
    for j in 1:M
        d[j] = e[j,2] - e[j,1]
    end
    return d
end

function f_p(e,d,p,q)
	pref = fill(0.0, M)
	for j in 1:M
		if d[j] ≤ q[j]
			pref[j] = 0
		elseif d[j] ≥ p[j]
			pref[j] = 1
		else
			if 1 ≤ j ≤ 9
				pref[j] = (d[j]^3.2) / (5^3.2)
			elseif 10 ≤ j ≤ 19
				pref[j] = (d[j]^0.4) / (5^0.4)
			else 20 ≤ j 
				pref[j] = d[j] / (p[j] - q[j])
			end
		end
	end
	pref = round.(pref, digits=3)
	return pref
end

function f_π1(P, weight)
   l = sum( P[j] * weight[j] for j in 1:M ) / sum(weight)
    l = round(l , digits=4)
    return l
end

function initiate(i)
    weight = f_weight(μ_weight , σ_weight)
    d=f_d(e[i])
    P = f_p(e[i],d,p,q)
    π1 = f_π1(P, weight)
    return π1
end

initiate(3)

I = 3
K = 10000

function simulate()
    coA = ["Company A" for k in 1:K]
    coB = ["Company B" for k in 1:K]
    coC = ["Company C" for k in 1:K]
    Company = vcat(coA , coB , coC)
    
    l = fill(0.0,K*I)
    for i in 1:I   
        for k in 1:K
           l[k + (i-1)*K ] = initiate(i)
        end
    end
    df = DataFrame(Company = Company , Value = l )
    return  df
end

df = simulate()

CSV.write("data_set.csv" , df)
pwd()

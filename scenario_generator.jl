using Plots
using DataFrames, CSV
using Distributions, Random
using Statistics
weight = [10, 6,  6,  9,  2,  3,  8,  5,  8,  3,  5,  4,  2,  5,  3,  7,  5,  5,  2,  3,  6,  10,  4,  5,  5,  4,  2]

q = fill(0,27)
p = fill(4,27);
M = 27

function f_Wᵀ(weight)
    l = sum(weight)
    return l 
end

function f_d(e)
    d = fill(0.0, 27)
    for j in 1:27
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

function f_π1(P,weight)
    l = sum( P[j]*weight[j] for j in 1:M) / sum(weight)
    l = round(l, digits=4)
    return l
end

function f_e()
    #a = [4 3 2 2 2 3 4 2 2 4 4 3 2 2 3 4 4 2 3 2 4 3 3 2 3 3 4]
    #a = [5 5 5 5 5 4 1 5 5 5 2 1 2 5 5 5 5 5 5 5 2 5 5 5 1 2 3]
    a = [4 1 5 1 1 2 1 3 5 1 1 1 1 2 1 3 3 5 5 5 1 2 3 1 2 2 3]
    UB = fill(5 , 27)
    a = [rand(a[j]:5) for j in 1:M]
    e = hcat(a,UB);
    #@show e[1:5,:]
    return e
end

function initiate()
   e = f_e()
   d = f_d(e)
   P = f_p(e,d,p,q)
   π1 = f_π1(P,weight)
   return  vcat(e[:,1], π1)
end

initiate()

K = 100000
function simulate()
    l = fill(0.0,K,28)
    for k in 1:K
        l[k,:] = initiate()
    end
    return l
end
ss_C = simulate()

df_C = DataFrame(ss_C , :auto)
CSV.write("df_C.csv", df_C)

pwd()

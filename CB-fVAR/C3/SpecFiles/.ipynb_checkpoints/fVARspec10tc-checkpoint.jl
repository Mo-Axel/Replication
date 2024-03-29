# specify quantiles to be used and approximation degrees K
quant_vec = [0.01, 0.025, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.80, 0.85, 0.9, 0.95, 0.975]


quant_sel = zeros(Int8, 10,22)

quant_sel[1,7]  = 1 # 0.25
quant_sel[1,13] = 1 # 0.55
quant_sel[1,17] = 1 # 0.75


quant_sel[2,:] = quant_sel[1,:];
quant_sel[2,4] = 1; # 0.10
quant_sel[2,20] = 1; # 0.90

quant_sel[3,:] = quant_sel[2,:];
quant_sel[3,1] = 1; # 0.01
quant_sel[3,10] = 1; # 0.40

quant_sel[4,:] = quant_sel[3,:];
quant_sel[4,1] = 1; # 0.01
quant_sel[4,2] = 1; # 0.025
# quant_sel[1,11]  = 1 # 0.45
# quant_sel[1,16] = 1 # 0.7
# quant_sel[1,4] = 1 # 0.10


# quant_sel[2,:] = quant_sel[1,:];
# quant_sel[2,7] = 1; # 0.25
# quant_sel[2,20] = 1; # 0.85

# quant_sel[3,:] = quant_sel[2,:];
# quant_sel[3,1] = 1; # 0.01
# quant_sel[3,10] = 1; # 0.40

# quant_sel[4,:] = quant_sel[3,:];
# quant_sel[4,1] = 1; # 0.01
# quant_sel[4,21] = 1; # 0.95

quant_sel[5,:] = quant_sel[4,:];
quant_sel[5,5] = 1;
quant_sel[5,9] = 1;
quant_sel[5,15] = 1;
quant_sel[5,19] = 1;

quant_sel[6,:] = quant_sel[5,:];
quant_sel[6,6] = 1;
quant_sel[6,10] = 1;
quant_sel[6,14] = 1;
quant_sel[6,18] = 1;

quant_sel[7,:] = quant_sel[6,:];
quant_sel[7,8] = 1;
quant_sel[7,11] = 1;
quant_sel[7,13] = 1;
quant_sel[7,16] = 1;


# quant_sel = quant_sel[1:7,:]
quant_sel = quant_sel[1:3,:]


#quant_sel = quant_sel[1:6,:];

K_vec     = sum(quant_sel,dims=2)
K_vec_n   = length(K_vec)
K_vec     = K_vec + ones(Int8, K_vec_n)

# specify grid that is used to evaluate p(x)
xmin = 0
xmax = 1
xn = 101
xgrid = range(xmin, stop=xmax, length=xn);

const TopCodeFlag = 0.95

# Option 3: cubic - cubic - linear, constructed from the right
##############################################################
function basis_logspline(x,knots)
    # this procedure evaluates the spline basis functions
    # at the n*1 vector x, given the (K-1)*1 vector of knots
    # output is  n*K
    UpperBound = 1

    x_dim  = length(x);
    K      = length(knots)+1;
    basis_fcn = zeros(x_dim,K);

    for j = 1:x_dim

        basis_fcn[j,K] = max(UpperBound-x[j],0);
        for i=(K-1):-1:1
             basis_fcn[j,i] = (max( (knots[i]-x[j]) , 0)^3);
        end

    end

    return basis_fcn

end

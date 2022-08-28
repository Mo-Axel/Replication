function loadaggdata(SampleStart,SampleEnd,v)

    dataDir = "$(pwd())/Data/"

    GDP_data       = CSV.read(dataDir * "gdp.csv", DataFrame, header = true); # run with version 1.5.
    Inv_data       = CSV.read(dataDir * "Inv.csv", DataFrame, header = false);
    BRW_data       = CSV.read(dataDir * "BRW.csv", DataFrame, header = false);
    # TFPgr_data       = CSV.read(dataDir * "Inv.csv", DataFrame, header = false);
    # unrate_data       = CSV.read(dataDir * "UNRATE_CPS_FRED.csv", DataFrame, header = true);

    # # initial transformations
    # period_GDP = Matrix(GDPpc_data)[:,1]
    # GDPpc      = log.(Matrix(GDPpc_data)[:,2])
    period_GDP  = Matrix(GDP_data)[:,1]
    GDPpc       = Matrix(GDP_data)[:,2]
    period_Inv  = Matrix(Inv_data)[:,1]
    Invpc       = Matrix(Inv_data)[:,2]
    period_BRW  = Matrix(BRW_data)[:,1]
    BRWpc       = Matrix(BRW_data)[:,2]
    # period_TFP = Matrix(TFPgr_data)[:,1]
    # TFPgr      = Matrix(TFPgr_data)[:,2]
    # #TFPutilgr = convert(Array, TFPgr_data[:,3])

    # period_UNR = Matrix(unrate_data)[:,1]
    # UNR        = Matrix(unrate_data)[:,2]
    # #earnings_detrended = convert(Array,earnings_data[:,3])
    # #earnings_t = convert(Array,earnings_data[:,2])

    # # compute GDP growth rates
    # GDPpcgr        = zeros(size(GDPpc))
    # GDPpcgr[2:end] = 400*(GDPpc[2:end]-GDPpc[1:end-1])

    # # accumulate TFP growth rates
    # TFP            = cumsum(TFPgr/400,dims=1)

    # # trim the sample
    # period_TFP_ind = (SampleStart .<= period_TFP .<= SampleEnd)
    # period_GDP_ind = (SampleStart .<= period_GDP .<= SampleEnd)
    # period_UNR_ind = (SampleStart .<= period_UNR .<= SampleEnd)
    period_GDP_ind = (SampleStart .<= period_GDP .<= SampleEnd)
    period_Inv_ind = (SampleStart .<= period_Inv .<= SampleEnd)
    period_BRW_ind = (SampleStart .<= period_BRW .<= SampleEnd)
    # GDPpc   = GDPpc[period_GDP_ind]
    # GDPpcgr = GDPpcgr[period_GDP_ind]
    # TFP     = TFP[period_TFP_ind]
    # TFPgr   = TFPgr[period_TFP_ind]
    # unrate  = UNR[period_UNR_ind];
    GDPpc    = GDPpc[period_GDP_ind]
    Invpc    = GDPpc[period_GDP_ind]
    BRWpc    = GDPpc[period_GDP_ind]

    period_agg = period_GDP[period_GDP_ind]

    GDPgrdev     = GDPpc .- mean(GDP_data,dims=1)
    Invgrdev     = Invpc .- mean(Inv_data::Any)
    BRWdev       = BRWpc .- mean(BRW_data::Any)

    # TFPgrdev     = TFPgr .- mean(TFPgr,dims=1)
    # GDPpcgrdev   = GDPpcgr .- mean(GDPpcgr,dims=1)
    # UNRdev       = unrate .- mean(unrate,dims=1);
    # agg_data     = [TFPgrdev GDPpcgrdev UNRdev]
    agg_data      = [GDPgrdev Invgrdev BRWdev]
    # n_agg        = size(agg_data)[2]

    #mean_unrate = mean(unrate,dims=1)[1]

    return agg_data, period_agg

end

##下面的没改呢

function loaddensdata(SampleStart,SampleEnd,K,nfVARSpec,v)

    sNameFile = "K" * string(K) * "_fVAR" * nfVARSpec
    PhatDensCoef_factor = CSV.read(loaddir * sNameFile * "_PhatDensCoef_factor.csv", DataFrame, header = true);
    PhatDensCoef_lambda = CSV.read(loaddir * sNameFile * "_PhatDensCoef_lambda.csv", DataFrame, header = true);
    PhatDensCoef_mean   = CSV.read(loaddir * sNameFile * "_PhatDensCoef_mean.csv", DataFrame, header = true);
    PhatDensCoef_mean_allt = CSV.read(loaddir * sNameFile * "_PhatDensCoef_mean_allt.csv", DataFrame, header = true);
    period_Dens         = CSV.read(loaddir * sNameFile * "_DensityPeriod.csv", DataFrame, header = true);
    MDD_GoF             = CSV.read(loaddir * sNameFile * "_MDD_GoF.csv", DataFrame, header = true);
    Vinv_all            = CSV.read(loaddir * sNameFile * "_Vinv_all.csv", DataFrame, header = true);
    N_all               = CSV.read(loaddir * sNameFile * "_N_all.csv", DataFrame, header = true);


    period_Dens         = Matrix(period_Dens)
    period_Dens_ind     = dropdims((SampleStart .<= period_Dens .<= SampleEnd),dims=2)
    period_Dens         = period_Dens[period_Dens_ind]
    PhatDensCoef_factor = Matrix(PhatDensCoef_factor)
    PhatDensCoef_factor = PhatDensCoef_factor[period_Dens_ind,:]
    PhatDensCoef_lambda = Matrix(PhatDensCoef_lambda)
    PhatDensCoef_mean   = Matrix(PhatDensCoef_mean)
    PhatDensCoef_mean_allt = Matrix(PhatDensCoef_mean_allt)
    PhatDensCoef_mean_allt = PhatDensCoef_mean_allt[period_Dens_ind,:]
    MDD_GoF             = Matrix(MDD_GoF)
    MDD_GoF             = MDD_GoF[period_Dens_ind]
    N_all               = Matrix(N_all)
    Vinv_all            = Matrix(Vinv_all)
    Ktilde              = size(PhatDensCoef_lambda)[1]

    VinvLam_all = zeros(Ktilde, Ktilde, sum(period_Dens_ind))

    # Load ME covariance matrices
    # Needs to be adjusted for Lambda
    tt_sel = 1
    for tt = 1:size(period_Dens_ind)[1]
        if period_Dens_ind[tt] == true # restrict to periods between SampleStart and SampleEnd
            Vinv_t = Symmetric(Vinv_all[K*(tt-1)+1:K*tt,:])
            VinvLam_all[:,:,tt_sel] = PhatDensCoef_lambda*Vinv_t*PhatDensCoef_lambda'*N_all[tt]
            tt_sel = tt_sel + 1
        end
    end

    return PhatDensCoef_factor, MDD_GoF, VinvLam_all, period_Dens_ind, PhatDensCoef_lambda, PhatDensCoef_mean, PhatDensCoef_mean_allt

end

﻿using module ..\Include.psm1

param(
    [PSCustomObject]$Pools,
    [PSCustomObject]$Stats,
    [PSCustomObject]$Config,
    [PSCustomObject[]]$Devices
)

$Path = ".\Bin\Excavator\excavator.exe"
$HashSHA256 = "4CC2FF8C07F17E940A1965B8D0F7DD8508096A4E4928704912FA96C442346642"
$Uri = "https://github.com/nicehash/excavator/releases/download/v1.4.4a/excavator_v1.4.4a_NVIDIA_Win64.zip"
$Port = "5100"

$Commands = [PSCustomObject[]]@(
    #[PSCustomObject]@{Algorithm = "daggerhashimoto"; Threads = 1; Params = @()} #Ethash   --- PROFIT <<< ExcavatorNvidia2 < ExcavatorNvidia1 < Eminer < ClaymoreNvidia < EthminerNvidia < PhoenixMinerNvidia
    [PSCustomObject]@{Algorithm = "equihash"; Threads = 1; Params = @()} #Equihash   <<< CcminerNanashi < CcminerSkunk < CcminerNevermore < CcminerAllium < CcminerSuprMiner < CcminerTpruvot < ExcavatorNvidia1 < Dstm < Ewbf < ExcavatorNvidia2 < BMiner
    #[PSCustomObject]@{Algorithm = "lbry"; Threads = 1; Params = @()} #Lbry   ASIC - never profitable 20/04/2018
    [PSCustomObject]@{Algorithm = "lyra2rev2"; Threads = 1; Params = @()} #Lyra2RE2   <<< CcminerPolytimos < ExcavatorNvidia2 < CcminerCornzKeccakC < ExcavatorNvidia1 < CcminerXevan < CcminerAnxmodPhi < CcminerAlexis < CcminerNanashi < CcminerLyra2RE2 < CcminerSkunk < CcminerTpruvot < CcminerAllium < CcminerSuprMiner < CcminerNevermore < CcminerSib < CcminerKlaust < CcminerSp < CcminerLyra2z
    [PSCustomObject]@{Algorithm = "neoscrypt"; Threads = 1; Params = @()} #NeoScrypt   <<< CcminerSp < CcminerLyra2RE2 < CcminerSuprMiner < CcminerSib < NsgminerNvidia < CcminerLyra2z < CcminerKlaust < CcminerTpruvot < CcminerAllium < CcminerNevermore < CcminerSkunk < CcminerNanashi < JustAMinerNeoScrypt < ExcavatorNvidia1
    #[PSCustomObject]@{Algorithm = "daggerhashimoto"; Threads = 2; Params = @()} #Ethash   --- PROFIT <<< ExcavatorNvidia2 < ExcavatorNvidia1 < Eminer < ClaymoreNvidia < EthminerNvidia < PhoenixMinerNvidia
    [PSCustomObject]@{Algorithm = "equihash"; Threads = 2; Params = @()} #Equihash   <<< CcminerNanashi < CcminerSkunk < CcminerNevermore < CcminerAllium < CcminerSuprMiner < CcminerTpruvot < ExcavatorNvidia1 < Dstm < Ewbf < ExcavatorNvidia2 < BMiner
    #[PSCustomObject]@{Algorithm = "lbry"; Threads = 2; Params = @()} #Lbry   ASIC - never profitable 20/04/2018
    [PSCustomObject]@{Algorithm = "lyra2rev2"; Threads = 2; Params = @()} #Lyra2RE2   <<< CcminerPolytimos < ExcavatorNvidia2 < CcminerCornzKeccakC < ExcavatorNvidia1 < CcminerXevan < CcminerAnxmodPhi < CcminerAlexis < CcminerNanashi < CcminerLyra2RE2 < CcminerSkunk < CcminerTpruvot < CcminerAllium < CcminerSuprMiner < CcminerNevermore < CcminerSib < CcminerKlaust < CcminerSp < CcminerLyra2z
    #[PSCustomObject]@{Algorithm = "neoscrypt"; Threads = 2; Params = @()} #NeoScrypt out of memory
    #[PSCustomObject]@{Algorithm = "daggerhashimoto_decred"; Threads = 1; Params = @()} #Dual mining 1 thread   --- PROFIT
    #[PSCustomObject]@{Algorithm = "daggerhashimoto_pascal"; Threads = 1; Params = @()} #Dual mining 1 thread   --- PROFIT
    #[PSCustomObject]@{Algorithm = "daggerhashimoto_sia"; Threads = 1; Params = @()} #Dual mining 1 thread   --- PROFIT
    #[PSCustomObject]@{Algorithm = "daggerhashimoto_decred"; Threads = 2; Params = @()} #Dual mining 2 threads   --- PROFIT
    #[PSCustomObject]@{Algorithm = "daggerhashimoto_pascal"; Threads = 2; Params = @()} #Dual mining 2 threads   --- PROFIT
    #[PSCustomObject]@{Algorithm = "daggerhashimoto_sia"; Threads = 2; Params = @()} #Dual mining 2 threads   --- PROFIT

    #ASIC mining only 2018/06/11
    #[PSCustomObject]@{Algorithm = "decred"; Threads = 1; Params = @()} #Pascal
    #[PSCustomObject]@{Algorithm = "decred"; Threads = 2; Params = @()} #Pascal
    #[PSCustomObject]@{Algorithm = "pascal"; Threads = 1; Params = @()} #Pascal   <<< ExcavatorNvidia1 < ExcavatorNvidia2
    #[PSCustomObject]@{Algorithm = "pascal"; Threads = 2; Params = @()} #Pascal   --- PROFIT <<< ExcavatorNvidia1 < ExcavatorNvidia2
    #[PSCustomObject]@{Algorithm = "sia"; Threads = 1; Params = @()} #Pascal
    #[PSCustomObject]@{Algorithm = "sia"; Threads = 2; Params = @()} #Pascal
    
    # MPM forgot these
    #[PSCustomObject]@{Algorithm = "cryptonight"; Threads = 1; Params = @()} #CryptoNight   <<< CcminerTpruvot < ExcavatorNvidia1 < ExcavatorNvidia2 < CcminerAllium < CcminerNevermore
    #[PSCustomObject]@{Algorithm = "cryptonight"; Threads = 2; Params = @()} #CryptoNight   <<< CcminerTpruvot < ExcavatorNvidia1 < ExcavatorNvidia2 < CcminerAllium < CcminerNevermore
    [PSCustomObject]@{Algorithm = "keccak"; Threads = 1; Params = @()} #Keccak   <<< CcminerPolytimos < CcminerSkunk < CcminerNanashi < CcminerLyra2RE2 < CcminerLyra2z < CcminerSib < CcminerSuprMiner < CcminerAllium < CcminerSp < CcminerNevermore < CcminerAnxmodPhi < CcminerTpruvot < CcminerAlexis < CcminerKlaust < CcminerXevan < CcminerCornzKeccakC < ExcavatorNvidia1 < ExcavatorNvidia2
    [PSCustomObject]@{Algorithm = "keccak"; Threads = 2; Params = @()} #Keccak   <<< CcminerPolytimos < CcminerSkunk < CcminerNanashi < CcminerLyra2RE2 < CcminerLyra2z < CcminerSib < CcminerSuprMiner < CcminerAllium < CcminerSp < CcminerNevermore < CcminerAnxmodPhi < CcminerTpruvot < CcminerAlexis < CcminerKlaust < CcminerXevan < CcminerCornzKeccakC < ExcavatorNvidia1 < ExcavatorNvidia2
)

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName
$Devices = @($Devices | Where-Object Type -EQ "GPU" | Where-Object Vendor -EQ "NVIDIA Corporation")

$Devices | Select-Object Vendor, Model -Unique | ForEach-Object {
    $Miner_Device = @($Devices | Where-Object Vendor -EQ $_.Vendor | Where-Object Model -EQ $_.Model)
    $Miner_Port = $Port -f ($Miner_Device | Select-Object -First 1 -ExpandProperty Index)

    $Commands | ForEach-Object {
        $Algorithm = $_.Algorithm
        $Main_Algorithm = $Algorithm -Split "_" | Select-Object -Index 0
        $Main_Algorithm_Norm = Get-Algorithm $Main_Algorithm
        $Secondary_Algorithm = $Algorithm -Split "_" | Select-Object -Index 1
        $Secondary_Algorithm_Norm = Get-Algorithm $Secondary_Algorithm
        $Threads = $_.Threads
        $Params = $_.Params

        if ($Pools.$Main_Algorithm_Norm.Host) {
            if (-not $Secondary_Algorithm) {
                #Single algo mining
                $Miner_Name = (@($Name) + @($Threads) + @($Miner_Device.Name | Sort-Object) | Select-Object) -join '-'

                [PSCustomObject]@{
                    Name             = $Miner_Name
                    DeviceName       = $Miner_Device.Name
                    Path             = $Path
                    HashSHA256       = $HashSHA256
                    Arguments        = @([PSCustomObject]@{id = 1; method = "algorithm.add"; params = @("$Main_Algorithm", "$([Net.DNS]::Resolve($Pools.$Main_Algorithm_Norm.Host).AddressList.IPAddressToString | Select-Object -First 1):$($Pools.$Main_Algorithm_Norm.Port)", "$($Pools.$Main_Algorithm_Norm.User):$($Pools.$Main_Algorithm_Norm.Pass)")}) + @([PSCustomObject]@{id = 1; method = "workers.add"; params = @(@($Miner_Device.Type_PlatformId_Index | ForEach-Object {@("alg-0", "$_")} | Select-Object) * $Threads) + $Params})
                    HashRates        = [PSCustomObject]@{$Main_Algorithm_Norm = $Stats."$($Miner_Name)_$($Main_Algorithm_Norm)_HashRate".Week}
                    API              = "Excavator"
                    Port             = $Miner_Port
                    URI              = $Uri
                    PrerequisitePath = "$env:SystemRoot\System32\msvcr120.dll"
                    PrerequisiteURI  = "http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe"
                }
            }
            else {
                #Dual algo mining
                if ($Pools.$Secondary_Algorithm_Norm.Host ) {
                    $Miner_Name = (@($Name) + @("$Secondary_Algorithm_Norm") + @($Threads) + @($Miner_Device.Name | Sort-Object) | Select-Object) -join '-'

                    [PSCustomObject]@{
                        Name             = $Miner_Name
                        DeviceName       = $Miner_Device.Name
                        Path             = $Path
                        HashSHA256       = $HashSHA256
                        Arguments        = @([PSCustomObject]@{id = 1; method = "algorithm.add"; params = @("$Algorithm", "$([Net.DNS]::Resolve($Pools.$Main_Algorithm_Norm.Host).AddressList.IPAddressToString | Select-Object -First 1):$($Pools.$Main_Algorithm_Norm.Port)", "$($Pools.$Main_Algorithm_Norm.User):$($Pools.$Main_Algorithm_Norm.Pass)", "$([Net.DNS]::Resolve($Pools.$Secondary_Algorithm_Norm.Host).AddressList.IPAddressToString | Select-Object -First 1):$($Pools.$Secondary_Algorithm_Norm.Port)", "$($Pools.$Secondary_Algorithm_Norm.User):$($Pools.$Secondary_Algorithm_Norm.Pass)")}) + @([PSCustomObject]@{id = 1; method = "workers.add"; params = @(@($Miner_Device.Type_PlatformId_Index | ForEach-Object {@("alg-0", "$_")} | Select-Object) * $Threads) + $Params})
                        HashRates        = [PSCustomObject]@{$Main_Algorithm_Norm = $Stats."$($Miner_Name)_$($Main_Algorithm_Norm)_HashRate".Week; $Secondary_Algorithm_Norm = $Stats."$($Miner_Name)_$($Secondary_Algorithm_Norm)_HashRate".Week}
                        API              = "Excavator"
                        Port             = $Miner_Port
                        URI              = $Uri
                        PrerequisitePath = "$env:SystemRoot\System32\msvcr120.dll"
                        PrerequisiteURI  = "http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe"
                    }
                }
            }
        }
    }
}

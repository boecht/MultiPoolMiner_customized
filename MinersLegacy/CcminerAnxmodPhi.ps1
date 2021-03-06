﻿using module ..\Include.psm1

$Path = ".\Bin\NVIDIA-PHI\ccminer.exe"
$HashSHA256 = "6C3AFFABBD39566F4AE3B78CF55BFEA06BE98C1D48FDDB27DEE406DB87B7663F"
$URI = "https://github.com/216k155/ccminer-phi-anxmod/releases/download/ccminer%2Fphi-1.0/ccminer-phi-1.0.zip"

$Commands = [PSCustomObject]@{
    #"Phi" = "" #Phi Phi1612 LUX   <<< CcminerAnxmodPhi < CcminerSuprMiner < CcminerTpruvot < CcminerAllium < CcminerNevermore < CcminerZealot
    
    # MPM forgot these
    #"blake" = "" #Blake256-14rounds(SFR)
    #"decred" = "" #Blake256-14rounds(DCR)
    #"blakecoin" = "" #Blake256-8rounds (BLC)
    "vcash" = "" #Blake256-8rounds (XVC)
    #"blake2s" = "" #Blake2s (NEVA/XVG)
    "keccak" = "" #keccak256 (Maxcoin)   <<< CcminerPolytimos < CcminerSkunk < CcminerNanashi < CcminerLyra2RE2 < CcminerLyra2z < CcminerSib < CcminerSuprMiner < CcminerAllium < CcminerSp < CcminerNevermore < CcminerAnxmodPhi < CcminerTpruvot < CcminerAlexis < CcminerKlaust < CcminerXevan < CcminerCornzKeccakC < ExcavatorNvidia1 < ExcavatorNvidia2
    "hsr" = "" #X13+SM3 (Hshare)   <<< CcminerSuprMiner < CcminerAllium < CcminerTpruvot < CcminerNevermore < CcminerAnxmodPhi < CcminerPolytimos < CcminerAlexis
    "lyra2" = "" #(LyraBar)   <<< CcminerSp < CcminerSib < CcminerLyra2RE2 < CcminerLyra2z < CcminerSkunk < CcminerNanashi < CcminerSuprMiner < CcminerNevermore < CcminerTpruvot < CcminerAllium < CcminerXevan < CcminerPolytimos < CcminerCornzKeccakC < CcminerAlexis < CcminerAnxmodPhi
    "lyra2v2" = "" #(VertCoin)   <<< CcminerPolytimos < ExcavatorNvidia2 < CcminerCornzKeccakC < ExcavatorNvidia1 < CcminerXevan < CcminerAnxmodPhi < CcminerAlexis < CcminerNanashi < CcminerLyra2RE2 < CcminerSkunk < CcminerTpruvot < CcminerAllium < CcminerSuprMiner < CcminerNevermore < CcminerSib < CcminerKlaust < CcminerSp < CcminerLyra2z
    "skein" = "" #Skein SHA2 (AUR/DGB/SKC)   <<< CcminerNevermore < CcminerLyra2RE2 < CcminerAllium < CcminerSuprMiner < CcminerSkunk < CcminerLyra2z < CcminerNanashi < CcminerSib < CcminerAlexis < CcminerKlaust < CcminerSp < CcminerXevan < CcminerPolytimos < CcminerCornzKeccakC < CcminerAnxmodPhi
    "skein2" = "" #Double Skein (Woodcoin)
    #"nist5" = "" #NIST5 (Talkcoin/Power)
    #"quark" = "" #Quark (Quarkcoin)
    #"qubit" = "" #Qubit
    #"x11" = "" #X11 (DarkCoin)
    #"c11" = "" #C11 (Chaincoin)   --- BROKEN
    #"sib" = "" #X11+gost (Sibcoin)
    #"x11evo" = "" #Permuted x11 (Revolver)   --- BROKEN   <<< CcminerNanashi < CcminerSkunk < CcminerTpruvot < CcminerAllium < CcminerSuprMiner < CcminerLyra2z < CcminerNevermore < CcminerSib < CcminerAlexis
    #"x13" = "" #X13 (MaruCoin)
    #"x14" = "" #X14 (BernCoin)
    #"x15" = "" #X15 (Joincoin)
    #"x17" = "" #X17 (XVG)   --- BROKEN
    "whirlpool" = "" #whirlpool (JoinCoin)
    #"lbry" = "" #Lbry (Library Credits)
    #"neoscrypt" = "" #Neoscrypt (FTC/PXC/UFO)   --- BROKEN
    #"sia" = "" #Sia (SIAcoin)
    #"myr-gr" = "" #Myriad-Groestl (SFR/AUR/DGB/XVG/MYR)
    "veltor" = "" #Thor's Riddle(?) (Veltor)
}

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | Where-Object {$Pools.(Get-Algorithm $_).Protocol -eq "stratum+tcp" <#temp fix#>} | ForEach-Object {

    $Algorithm_Norm = Get-Algorithm $_

    Switch ($Algorithm_Norm) {
        "PHI"   {$ExtendInterval = 3}
        default {$ExtendInterval = 0}
    }

    [PSCustomObject]@{
        Type           = "NVIDIA"
        Path           = $Path
        HashSHA256     = $HashSHA256
        Arguments      = "-a $_ -o $($Pools.$Algorithm_Norm.Protocol)://$($Pools.$Algorithm_Norm.Host):$($Pools.$Algorithm_Norm.Port) -u $($Pools.$Algorithm_Norm.User) -p $($Pools.$Algorithm_Norm.Pass)$($Commands.$_)"
        HashRates      = [PSCustomObject]@{$Algorithm_Norm = $Stats."$($Name)_$($Algorithm_Norm)_HashRate".Week}
        API            = "Ccminer"
        Port           = 4068
        URI            = $Uri
        ExtendInterval = $ExtendInterval
    }
}

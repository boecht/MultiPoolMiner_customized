﻿using module ..\Include.psm1

$Path = ".\Bin\NVIDIA-SuprMiner\ccminer.exe"
$HashSHA256 = "6DE5DC4F109951AE1591D083F5C2A6494C9B59470C15EF6FBE5D38C50625304B"
$Uri = "https://github.com/ocminer/suprminer/releases/download/1.5/suprminer-1.5.7z"

$Commands = [PSCustomObject]@{
    "bitcore"     = "" #Bitcore   <<< CcminerSuprMiner < CcminerNanashi < CcminerSkunk < CcminerAllium < CcminerTpruvot < CcminerNevermore < CcminerZealot
    "c11"         = "" #C11   <<< CcminerLyra2RE2 < CcminerNanashi < CcminerSkunk < CcminerLyra2z < CcminerTpruvot < CcminerKlaust < CcminerNevermore < CcminerSuprMiner < CcminerSp < CcminerSib < CcminerAlexis
    #"groestl"    = "" #Groestl   <<< CcminerNanashi < CcminerNevermore < CcminerLyra2RE2 < CcminerTpruvot < CcminerAllium < CcminerLyra2z < CcminerSuprMiner < CcminerSkunk < CcminerSp < CcminerKlaust
    "hmq1725"    = "" #HMQ1725   <<< CcminerNanashi < CcminerSkunk < CcminerAllium < CcminerTpruvot < CcminerSuprMiner < CcminerNevermore
    "hsr"         = "" #HSR   <<< CcminerSuprMiner < CcminerAllium < CcminerTpruvot < CcminerNevermore < CcminerAnxmodPhi < CcminerPolytimos < CcminerAlexis
    "keccak"      = "" #Keccak   <<< CcminerPolytimos < CcminerSkunk < CcminerNanashi < CcminerLyra2RE2 < CcminerLyra2z < CcminerSib < CcminerSuprMiner < CcminerAllium < CcminerSp < CcminerNevermore < CcminerAnxmodPhi < CcminerTpruvot < CcminerAlexis < CcminerKlaust < CcminerXevan < CcminerCornzKeccakC < ExcavatorNvidia1 < ExcavatorNvidia2
    "keccakc"     = "" #Keccakc   <<< CcminerNevermore < CcminerSuprMiner < CcminerTpruvot < CcminerAllium < CcminerCornzKeccakC < CcminerAlexis
    "lyra2v2"    = "" #Lyra2RE2   <<< CcminerPolytimos < ExcavatorNvidia2 < CcminerCornzKeccakC < ExcavatorNvidia1 < CcminerXevan < CcminerAnxmodPhi < CcminerAlexis < CcminerNanashi < CcminerLyra2RE2 < CcminerSkunk < CcminerTpruvot < CcminerAllium < CcminerSuprMiner < CcminerNevermore < CcminerSib < CcminerKlaust < CcminerSp < CcminerLyra2z
    "lyra2z"     = "" #Lyra2z   <<< CcminerSkunk < CcminerNevermore < CcminerLyra2z < CcminerNanashi < CcminerSuprMiner < CcminerTpruvot < CcminerAllium
    "neoscrypt"   = "" #NeoScrypt   <<< CcminerSp < CcminerLyra2RE2 < CcminerSuprMiner < CcminerSib < NsgminerNvidia < CcminerLyra2z < CcminerKlaust < CcminerTpruvot < CcminerAllium < CcminerNevermore < CcminerSkunk < CcminerNanashi < JustAMinerNeoScrypt < ExcavatorNvidia1
    "phi"        = "" #PHI   <<< CcminerAnxmodPhi < CcminerSuprMiner < CcminerTpruvot < CcminerAllium < CcminerNevermore < CcminerZealot
    "skein"       = "" #Skein   <<< CcminerNevermore < CcminerLyra2RE2 < CcminerAllium < CcminerSuprMiner < CcminerSkunk < CcminerLyra2z < CcminerNanashi < CcminerSib < CcminerAlexis < CcminerKlaust < CcminerSp < CcminerXevan < CcminerPolytimos < CcminerCornzKeccakC < CcminerAnxmodPhi
    "skunk"       = "" #Skunk   <<< CcminerAllium < CcminerNevermore < CcminerSuprMiner < CcminerNanashi < CcminerSkunk
    "timetravel" = "" #Timetravel   <<< CcminerTpruvot < CcminerAllium < CcminerNanashi < CcminerSkunk < CcminerSuprMiner < CcminerNevermore
    "tribus"      = "" #Tribus   <<< CcminerSkunk < CcminerNanashi < CcminerNevermore < CcminerTpruvot < CcminerAllium < CcminerSuprMiner
    "x11evo"      = "" #X11evo   <<< CcminerNanashi < CcminerSkunk < CcminerTpruvot < CcminerAllium < CcminerSuprMiner < CcminerLyra2z < CcminerNevermore < CcminerSib < CcminerAlexis
    "x16r"        = "" #Raven
    "x16s"       = "" #Pigeon   <<< CcminerAllium < CcminerSuprMiner < CcminerNevermore < CcminerZealot
    "x17"         = "" #X17  <<< CcminerKlaust < CcminerLyra2RE2 < CcminerLyra2z < CcminerNanashi < CcminerSp < CcminerSuprMiner < CcminerSkunk < CcminerAllium < CcminerNevermore < CcminerAlexis < CcminerZealot
    
    # ASIC - never profitable 12/05/2018
    #"blake2s"   = "" #Blake2s
    #"blakecoin" = "" #Blakecoin
    #"decred"   = "" #Decred
    #"lbry"     = "" #Lbry
    #"myr-gr"   = "" #MyriadGroestl
    #"nist5"    = "" #Nist5
    #"qubit"    = "" #Qubit
    #"quark"    = "" #Quark
    #"sib"      = "" #Sib
    #"x11"      = "" #X11
    #"x13"      = "" #X13
    #"x14"      = "" #X14
    
    # MPM forgot these
    "bastion"      = "" #Joincoin
    #"blake"       = "" #Saffroncoin (Blake256)
    "bmw"          = "" #Midnight
    "cryptolight"  = "" #AEON cryptonight (MEM/2)
    #"cryptonight" = "" #XMR cryptonight, Bytecoin, Dash, DigitalNote, etc   --- BROKEN
    "deep"         = "" #Deepcoin
    "dmd-gr"       = "" #Diamond-Groestl
    "equihash"     = "" #ZEC, HUSH and KMD   <<< CcminerNanashi < CcminerSkunk < CcminerNevermore < CcminerAllium < CcminerSuprMiner < CcminerTpruvot < ExcavatorNvidia1 < Dstm < Ewbf < ExcavatorNvidia2 < BMiner
    "fresh"        = "" #Freshcoin
    "fugue256"     = "" #Fuguecoin
    "jackpot"      = "" #Sweepcoin
    "luffa"        = "" #Joincoin
    "lyra2"       = "" #CryptoCoin   <<< CcminerSp < CcminerSib < CcminerLyra2RE2 < CcminerLyra2z < CcminerSkunk < CcminerNanashi < CcminerSuprMiner < CcminerNevermore < CcminerTpruvot < CcminerAllium < CcminerXevan < CcminerPolytimos < CcminerCornzKeccakC < CcminerAlexis < CcminerAnxmodPhi
    "penta"        = "" #Joincoin / Pentablake
    "polytimos"    = "" #Polytimos
    #"scrypt"      = "" #Scrypt coins (Litecoin, Dogecoin, etc)
    #"scrypt:N"    = "" #Scrypt-N (:10 for 2048 iterations)
    "scrypt-jane"  = "" #Chacha coins like Cache and Ultracoin
    #"s3"          = "" #1coin (ONE) (SHA256t=S3)   <<< CcminerNanashi < CcminerSkunk < CcminerSp < CcminerKlaust < CcminerLyra2RE2 < CcminerSuprMiner < CcminerNevermore < CcminerLyra2z < CcminerTpruvot < CcminerAllium
    #"sha256t"     = "" #OneCoin (OC) (SHA256t=S3)   <<< CcminerNanashi < CcminerSkunk < CcminerSp < CcminerKlaust < CcminerLyra2RE2 < CcminerSuprMiner < CcminerNevermore < CcminerLyra2z < CcminerTpruvot < CcminerAllium
    #"sia"         = "" #SIA
    "skein2"       = "" #Woodcoin
    #"x15"         = "" #Halcyon
    #"vanilla"     = "" #Vanilla (Blake256)
    "veltor"       = "" #VeltorCoin
    "whirlpool"    = "" #Joincoin
    "wildkeccak"   = "" #Boolberry (Stratum only)
    "zr5"          = "" #ZiftrCoin
    #"sha256d"     = "" #SHA256d (bitcoin)
    "whirlcoin"    = "" #Old Whirlcoin (Whirlpool algo)
}

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | Where-Object {$Pools.(Get-Algorithm $_).Protocol -eq "stratum+tcp" <#temp fix#>} | ForEach-Object {

    $Algorithm_Norm = Get-Algorithm $_

    Switch ($Algorithm_Norm) {
        "PHI"   {$ExtendInterval = 3}
        "X16R"  {$ExtendInterval = 10}
        "X16S"  {$ExtendInterval = 10}
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

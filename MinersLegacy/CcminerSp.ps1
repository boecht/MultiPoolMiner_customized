﻿using module ..\Include.psm1

$Path = ".\Bin\NVIDIA-SP\ccminer.exe"
$HashSHA256 = "82477387C860517C5FACE8758BCB7AAC890505280BF713ACA9F86D7B306AC711"
$Uri = "https://github.com/sp-hash/ccminer/releases/download/1.5.81/release81.7z"

$Commands = [PSCustomObject]@{
    #GPU - profitable 20/04/2018
    "bastion" = "" #bastion
    "c11" = "" #C11   <<< CcminerLyra2RE2 < CcminerNanashi < CcminerSkunk < CcminerLyra2z < CcminerTpruvot < CcminerKlaust < CcminerNevermore < CcminerSuprMiner < CcminerSp < CcminerSib < CcminerAlexis
    "credit" = "" #Credit
    "deep" = "" #deep
    "dmd-gr" = "" #dmd-gr
    "fresh" = "" #fresh
    "fugue256" = "" #Fugue256
    #"groestl" = "" #Groestl   <<< CcminerNanashi < CcminerNevermore < CcminerLyra2RE2 < CcminerTpruvot < CcminerAllium < CcminerLyra2z < CcminerSuprMiner < CcminerSkunk < CcminerSp < CcminerKlaust
    "heavy" = "" #heavy
    "jackpot" = "" #JackPot
    "keccak" = "" #Keccak   <<< CcminerPolytimos < CcminerSkunk < CcminerNanashi < CcminerLyra2RE2 < CcminerLyra2z < CcminerSib < CcminerSuprMiner < CcminerAllium < CcminerSp < CcminerNevermore < CcminerAnxmodPhi < CcminerTpruvot < CcminerAlexis < CcminerKlaust < CcminerXevan < CcminerCornzKeccakC < ExcavatorNvidia1 < ExcavatorNvidia2
    "luffa" = "" #Luffa
    "lyra2" = "" #lyra2h   <<< CcminerSp < CcminerSib < CcminerLyra2RE2 < CcminerLyra2z < CcminerSkunk < CcminerNanashi < CcminerSuprMiner < CcminerNevermore < CcminerTpruvot < CcminerAllium < CcminerXevan < CcminerPolytimos < CcminerCornzKeccakC < CcminerAlexis < CcminerAnxmodPhi
    "lyra2v2" = "" #Lyra2RE2   <<< CcminerPolytimos < ExcavatorNvidia2 < CcminerCornzKeccakC < ExcavatorNvidia1 < CcminerXevan < CcminerAnxmodPhi < CcminerAlexis < CcminerNanashi < CcminerLyra2RE2 < CcminerSkunk < CcminerTpruvot < CcminerAllium < CcminerSuprMiner < CcminerNevermore < CcminerSib < CcminerKlaust < CcminerSp < CcminerLyra2z
    "mjollnir" = "" #Mjollnir
    "neoscrypt" = "" #NeoScrypt   <<< CcminerSp < CcminerLyra2RE2 < CcminerSuprMiner < CcminerSib < NsgminerNvidia < CcminerLyra2z < CcminerKlaust < CcminerTpruvot < CcminerAllium < CcminerNevermore < CcminerSkunk < CcminerNanashi < JustAMinerNeoScrypt < ExcavatorNvidia1
    "pentablake" = "" #pentablake
    "scryptjane:nf" = "" #scryptjane:nf
    "skein" = "" #Skein   <<< CcminerNevermore < CcminerLyra2RE2 < CcminerAllium < CcminerSuprMiner < CcminerSkunk < CcminerLyra2z < CcminerNanashi < CcminerSib < CcminerAlexis < CcminerKlaust < CcminerSp < CcminerXevan < CcminerPolytimos < CcminerCornzKeccakC < CcminerAnxmodPhi
    #"s3" = "" #S3 (SHA256t=S3)   <<< CcminerNanashi < CcminerSkunk < CcminerSp < CcminerKlaust < CcminerLyra2RE2 < CcminerSuprMiner < CcminerNevermore < CcminerLyra2z < CcminerTpruvot < CcminerAllium
    "spread" = "" #Spread
    "whirlpool" = "" #Whirlpool
    "whirlpoolx" = "" #whirlpoolx
    "x17" = "" #x17  <<< CcminerKlaust < CcminerLyra2RE2 < CcminerLyra2z < CcminerNanashi < CcminerSp < CcminerSuprMiner < CcminerSkunk < CcminerAllium < CcminerNevermore < CcminerAlexis < CcminerZealot
    
    # ASIC - never profitable 27/03/2018
    #"blake" = "" #blake
    #"blakecoin" = "" #Blakecoin
    #"blake2s" = "" #Blake2s
    #"decred" = "" #Decred
    #"lbry" = "" #Lbry
    #"myr-gr" = "" #MyriadGroestl
    #"nist5" = "" #Nist5
    #"quark" = "" #Quark
    #"qubit" = "" #Qubit
    #"scrypt" = "" #Scrypt
    #"scrypt:N" = "" #scrypt:N
    #"sha256d" = "" #sha256d Bitcoin
    #"sia" = "" #SiaCoin
    #"vanilla" = "" #BlakeVanilla
    #"x11" = "" #X11
    #"x13" = "" #x13
    #"x14" = "" #x14
    #"x15" = "" #x15
}

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | Where-Object {$Pools.(Get-Algorithm $_).Protocol -eq "stratum+tcp" <#temp fix#>} | ForEach-Object {

    $Algorithm_Norm = Get-Algorithm $_

    [PSCustomObject]@{
        Type       = "NVIDIA"
        Path       = $Path
        HashSHA256 = $HashSHA256
        Arguments  = "-a $_ -o $($Pools.$Algorithm_Norm.Protocol)://$($Pools.$Algorithm_Norm.Host):$($Pools.$Algorithm_Norm.Port) -u $($Pools.$Algorithm_Norm.User) -p $($Pools.$Algorithm_Norm.Pass) -b 4068$($Commands.$_)"
        HashRates  = [PSCustomObject]@{$Algorithm_Norm = $Stats."$($Name)_$($Algorithm_Norm)_HashRate".Week}
        API        = "Ccminer"
        Port       = 4068
        URI        = $Uri
    }
}

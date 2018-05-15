﻿using module ..\Include.psm1

$Path = ".\Bin\Xevan-NVIDIA\ccminer_x86.exe"
$HashSHA256 = "E71488C61263C080964596B72880F04AC20E91A00CB6A217BCE7863685705243"
$Uri = "https://github.com/nemosminer/ccminer-xevan/releases/download/ccminer-xevan/ccminer_x86.7z"

$Commands = [PSCustomObject]@{
    "keccak"    = "" #Keccak
    "lyra2v2"   = "" #Lyra2RE2
    "skein"     = "" #Skein
    "xevan"     = "" #Xevan
    
    # ASIC - never profitable 12/05/2018
    #"blakecoin" = "" #Blakecoin
    #"blake2s"   = "" #Blake2s
    #"decred"   = "" #Decred
    #"lbry"     = "" #Lbry
    #"myr-gr"   = "" #MyriadGroestl
    #"nist5"    = "" #Nist5
    #"qubit"    = "" #Qubit
    #"quark"    = "" #Quark
    #"sia"      = "" #sia
    #"sib"      = "" #Sib
    #"x11"      = "" #X11
    #"x12"      = "" #X12
    #"x13"      = "" #X13
    #"x14"      = "" #X14
    #"x15"      = "" #X15
    
    # MPM forgot these
    #"blake"     = "" #Blakecoin
    "vcash"     = "" #Blake256-8rounds (XVC)
    "lyra2"     = "" #Lyra2RE
    "skein2"    = "" #Skein2
    #"c11"       = "" #C11   --- BROKEN
    #"x11evo"    = "" #X11evo   --- BROKEN
    "whirlpool" = "" #whirlpool
    #"neoscrypt" = "" #NeoScrypt   --- BROKEN
    "veltor"    = "" #Veltor
}

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | Where-Object {$Pools.(Get-Algorithm $_).Protocol -eq "stratum+tcp" <#temp fix#>} | ForEach-Object {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        HashSHA256 = $HashSHA256
        Arguments = "-a $_ -o $($Pools.(Get-Algorithm $_).Protocol)://$($Pools.(Get-Algorithm $_).Host):$($Pools.(Get-Algorithm $_).Port) -u $($Pools.(Get-Algorithm $_).User) -p $($Pools.(Get-Algorithm $_).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm $_) = $Stats."$($Name)_$(Get-Algorithm $_)_HashRate".Week}
        API = "Ccminer"
        Port = 4068
        URI = $Uri
    }
}

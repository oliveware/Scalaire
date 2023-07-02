//
//  File.swift
//  
//
//  Created by Herve Crespel on 19/11/2021.
//

import Foundation


public var ecritures : [Ecriture] = [.af, .als, .amh, .ar, .hy, .bibi, .bok, .br, .bro, .bsq, .bulc, .zh, .chol, .dan, .de, .elg, .en, .esto, .far, .fr, .hnd, .id, .irg, .isl, .it, .japa, .kor, .latin, .letton, .litua, .mal, .mapu, .nl, .np, .pic, .pol, .pt, .rhg, .rusc, .scg, .sp, .srp, .sue, .tif, .turc, .twn, .ukc, .viet, .wag ]

public var ecrituresparlées : [Ecriture] {
    var ep : [Ecriture] = []
    for i in 0..<ecritures.count {
        let ecriture = ecritures[i]
        let parle = bcp47[ecriture] ?? ""
        if parle != "" {
            ep.append(ecriture)
        }
    }
    return ep
}

public var ecrituresmuettes : [Ecriture] {
    var ep : [Ecriture] = []
    for i in 0..<ecritures.count {
        let ecriture = ecritures[i]
        let parle = bcp47[ecriture] ?? ""
        if parle == "" {
            ep.append(ecriture)
        }
    }
    return ep
}

// écritures acceptées par le text-to-speech
// https://support.apple.com/en-us/HT206175
public var bcp47 : [Ecriture:String] = [.ar:"ar", .bok:"nb-NO", .de:"de-DE", .elg:"el-GR", .en:"en-GB", .fl:"nl-BG", .fr:"fr-FR", .hnd:"hi-IN", .it:"it-IT", .japa:"ja-JP", .kor:"ko-KR", .nl:"nl-NL", .pol:"pl-PL", .pt:"pt-PT", .rusc:"ru-RU", .sp:"es-ES", .sue:"sv-SE", .turc:"tr-TR", .zh:"zh"]

public func dot(_ ecriture:Ecriture)->String{
    switch ecriture {
    case .af, .mal, .fr, .de, .it, .nl, .sp, .latin, .bg, .bulc, .letton, .litua, .esto, .dan, .isl, .bok, .rus, .rusc, .bsq, .serb, .srp, .pic, .turc, .sue, .als, .pol, .pt :
        return ","
    case .ar :
        return "٫"   // mommayez
    default:
        return "."
    }
}


public enum Ecriture: String, CaseIterable, Identifiable {
    case fr     = "français"
    case el     = "grec roman"        // romanisé
    case elg    = "grec moderne"
    case en     = "english"
    case de     = "deutsch"
    case it     = "italia"
    case sp     = "espana"
    case nl     = "nederlands"
    case fl     = "flanders"
    case br     = "breizh"
    case scg    = "scottish"        // gaélique écossais moderne
    case irg    = "irish"           // gaélique irlandais
    case wag    = "wales"           // gallois
    case bibi   = "bibi-binaire"    // breveté pat Boby Lapointe
    case bro    = "brooding"        // hexadécimal en lettres
    case latin  = "latin"
    case bg     = "bulgare roman"       // romanisé
    case bulc   = "bulgare"             // balgarsky
    case letton = "letton"
    case litua  = "lituanien"
    case esto   = "estonien"
    case dan    = "danois"
    case id     = "indonésien"
    case isl    = "islandais"
    case af     = "afrikaans"
    case bok    = "norvégien"       // bokmal
    case kanji  = "kanji"           // japonais en chiffres
    case japa   = "japonais"
    case japr   = "romaji"              // japonais romanisé
    case rus    = "russe roman"         // romanisé
    case rusc   = "russe"
    case uk     = "ukraine roman"       // romanisé
    case ukc    = "ukrainien"
    case bsq    = "basque"
    case serb   = "serbe roman"           // romanisé
    case srp    = "srpski"
    case pic    = "picard"
    case far    = "persan"
    case ar     = "arabe roman"           // romanisé
    case mapu   = "mapuche"
    case maya   = "maya"
    case turc   = "turc"
    case sue    = "suédois"
    case tif    = "tifinagh"
    case tmz    = "tamazight"           // tifinagh romanisé
    case hyr    = "armenien roman"       // romanisé
    case hy     = "arménien"            // hayeren
    case amh    = "amish"           // allemand pensylvanien
    case chol   = "ch'ol"           // maya écrit en ch'ol
    case als    = "alsacien"
    case mal    = "malais"          // indonésien
    case viet   = "vietnamien"
    case pin    = "pinyin"          // chinois romanisé
    case twn    = "taiwan"
    case pol    = "polski"
    case kor    = "coréen"              // hangeul
    case khj    = "hanja roman"          //  hanja romanisé
    case hnd    = "hindi"
    case rhg    = "rohingya"
    case pt     = "portuguès"
    case zh     = "chinois"
    case np     = "nepali"
    case uni    = "universel"
    
    public var id : String {self.rawValue}
}


// ecritures à choisir
// exclude optimise en oubliant ce qui a déjà été éliminé
public func otherscripts(_ exclude:[Ecriture]) -> [Ecriture]{
    var other :[Ecriture] = []
    var remain = exclude
    let all = ecritures
    for i in 0..<all.count {
        let item = all[i]
        var take = true
        var clude :[Ecriture] = []
        for r in 0..<remain.count{
            if item != remain[r] {
                clude.append(remain[r])
            } else {
                take = false
            }
        }
        if take {
            other.append(item)
            remain = clude
        } else {
            take = true
        }
    }
    return other
}

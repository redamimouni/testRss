//
//  ToiletDTO.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

// MARK: - RootToiletDTO
struct RootToiletDTO: Decodable {
    let nhits: Int
    let parameters: Parameters
    let records: [Record]
}

// MARK: - Parameters
struct Parameters: Decodable {
    let dataset: String
    let rows, start: Int
    let format, timezone: String
}

// MARK: - Record
struct Record: Decodable {
    let datasetid: String
    let recordid: String
    let fields: ToiletDTO
    let geometry: Geometry
    let recordTimestamp: String

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid, fields, geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - ToiletDTO
struct ToiletDTO: Decodable {
    let complementAdresse: ComplementAdresse
    let geoShape: GeoShape
    let horaire: Horaire
    let accesPmr: AccesPmr
    let arrondissement: Int?
    let geoPoint2D: [Double]
    let source: String
    let gestionnaire: Gestionnaire
    let adresse: String
    let type: FieldsType
    let urlFicheEquipement: String?
    let relaisBebe: AccesPmr?

    enum CodingKeys: String, CodingKey {
        case complementAdresse = "complement_adresse"
        case geoShape = "geo_shape"
        case horaire
        case accesPmr = "acces_pmr"
        case arrondissement
        case geoPoint2D = "geo_point_2d"
        case source, gestionnaire, adresse, type
        case urlFicheEquipement = "url_fiche_equipement"
        case relaisBebe = "relais_bebe"
    }
}

enum AccesPmr: String, Decodable {
    case non = "Non"
    case oui = "Oui"

    var boolean: Bool {
        switch self {
        case .non: return false
        case .oui: return true
        }
    }
}

enum ComplementAdresse: String, Decodable {
    case numeroDeVoieNomDeVoie = "numero_de_voie nom_de_voie"
}

// MARK: - GeoShape
struct GeoShape: Decodable {
    let coordinates: [[Double]]
    let type: GeoShapeType
}

enum GeoShapeType: String, Decodable {
    case multiPoint = "MultiPoint"
}

enum Gestionnaire: String, Decodable {
    case toilettePubliqueDeLaVilleDeParis = "Toilette publique de la Ville de Paris"
}

enum Horaire: String, Decodable {
    case the24H24 = "24 h / 24"
    case the6H22H = "6 h - 22 h"
    case voirFicheÉquipement = "Voir fiche équipement"
}

enum FieldsType: String, Decodable {
    case sanisette = "SANISETTE"
    case toilettes = "TOILETTES"
}

// MARK: - Geometry
struct Geometry: Decodable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Decodable {
    case point = "Point"
}


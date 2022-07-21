//
//  ToiletDTO.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

// MARK: - RootToiletDTO
struct RootToiletDTO: Codable {
    let nhits: Int
    let parameters: Parameters
    let records: [Record]
}

// MARK: - Parameters
struct Parameters: Codable {
    let dataset: Dataset
    let rows, start: Int
    let format, timezone: String
}

enum Dataset: String, Codable {
    case sanisettesparis2011 = "sanisettesparis2011"
}

// MARK: - Record
struct Record: Codable {
    let datasetid: Dataset
    let recordid: String
    let fields: ToiletDTO
    let geometry: Geometry
    let recordTimestamp: RecordTimestamp

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid, fields, geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - ToiletDTO
struct ToiletDTO: Codable {
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

enum AccesPmr: String, Codable {
    case non = "Non"
    case oui = "Oui"

    var boolean: Bool {
        return (self.rawValue as NSString).boolValue
    }
}

enum ComplementAdresse: String, Codable {
    case numeroDeVoieNomDeVoie = "numero_de_voie nom_de_voie"
}

// MARK: - GeoShape
struct GeoShape: Codable {
    let coordinates: [[Double]]
    let type: GeoShapeType
}

enum GeoShapeType: String, Codable {
    case multiPoint = "MultiPoint"
}

enum Gestionnaire: String, Codable {
    case toilettePubliqueDeLaVilleDeParis = "Toilette publique de la Ville de Paris"
}

enum Horaire: String, Codable {
    case the24H24 = "24 h / 24"
    case the6H22H = "6 h - 22 h"
    case voirFicheÉquipement = "Voir fiche équipement"
}

enum FieldsType: String, Codable {
    case sanisette = "SANISETTE"
    case toilettes = "TOILETTES"
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Codable {
    case point = "Point"
}

enum RecordTimestamp: String, Codable {
    case the20220704T041200502Z = "2022-07-04T04:12:00.502Z"
}


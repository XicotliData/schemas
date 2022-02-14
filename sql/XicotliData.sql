-- SQL dump generated using DBML (dbml-lang.org)
-- Database: PostgreSQL
-- Generated at: 2022-02-14T17:44:17.806Z

CREATE TABLE "Record" (
  "id" uuid PRIMARY KEY,
  "created_at" datetime DEFAULT (now()),
  "modified" datetime,
  "datasetName" char
);

CREATE TABLE "Taxon" (
  "id" uuid,
  "scientificName" char UNIQUE NOT NULL,
  "acceptedNameUsage" char,
  "family" char,
  "genus" char,
  "specificEpithet" char,
  "infraspecificEpithet" char,
  "taxonRank" char NOT NULL,
  "taxonomicStatus" char,
  "vernacularName" char
);

CREATE TABLE "Occurrence" (
  "id" uuid,
  "eventDate" date,
  "eventTime" time,
  "verbatimEventDay" char,
  "organismQuantity" numeric,
  "organismQuantityType" char,
  "recordedBy" char,
  "habitat" text,
  "islandGroup" char,
  "island" char,
  "country" char,
  "countryCode" char(2),
  "stateProvince" char,
  "municipality" char,
  "locality" char,
  "verbatimLocality" text,
  "decimalLatitude" numeric(6),
  "decimalLongitude" numeric(6),
  "geodeticDatum" char,
  "verbatimLatitude" char,
  "verbatimLongitude" char,
  "verbatimCoordinateSystem" char,
  "verbatimSRS" char,
  "georeferenceRemarks" text
);

CREATE TABLE "Measurements" (
  "id" uuid PRIMARY KEY,
  "name" char,
  "description" text
);

CREATE TABLE "MoF" (
  "record_id" uuid,
  "measurement_id" uuid,
  "value" char,
  "reference" text
);

CREATE TABLE "MediaItem" (
  "id" uuid PRIMARY KEY,
  "occurrence_id" uuid,
  "identifier" char,
  "type" char,
  "title" char,
  "dc_source" text,
  "created" date,
  "creator" char,
  "rightsHolder" char,
  "publisher" char,
  "licenseUrl" char,
  "format" char
);

CREATE TABLE "CollectionItem" (
  "occurrence_id" uuid,
  "institutionCode" char,
  "collectionCode" char,
  "bibliographicCitationURIPart" char,
  "catalogNumber" char,
  "recordNumber" char
);

CREATE TABLE "OccurrenceIdentification" (
  "taxon_id" uuid NOT NULL,
  "occurrence_id" uuid NOT NULL,
  "identifiedBy" char,
  "identifiedById" char,
  "dateIdentified" timestamp,
  "identificationRemarks" text
);

CREATE TABLE "TaxonInteraction" (
  "resource_id" uuid NOT NULL,
  "related_resource_id" uuid NOT NULL,
  "interactiontype_id" uuid NOT NULL,
  "relationshipAccordingTo" char,
  "relationshipEstablishedDate" timestamp,
  "relationshipRemarks" text
);

CREATE TABLE "InteractionType" (
  "id" uuid PRIMARY KEY,
  "label" char,
  "uri" char,
  "description" text
);

ALTER TABLE "Taxon" ADD FOREIGN KEY ("id") REFERENCES "Record" ("id");

ALTER TABLE "Occurrence" ADD FOREIGN KEY ("id") REFERENCES "Record" ("id");

ALTER TABLE "MoF" ADD FOREIGN KEY ("record_id") REFERENCES "Record" ("id");

ALTER TABLE "MoF" ADD FOREIGN KEY ("measurement_id") REFERENCES "Measurements" ("id");

ALTER TABLE "MediaItem" ADD FOREIGN KEY ("occurrence_id") REFERENCES "Occurrence" ("id");

ALTER TABLE "CollectionItem" ADD FOREIGN KEY ("occurrence_id") REFERENCES "Occurrence" ("id");

ALTER TABLE "TaxonInteraction" ADD FOREIGN KEY ("interactiontype_id") REFERENCES "InteractionType" ("id");

ALTER TABLE "OccurrenceIdentification" ADD FOREIGN KEY ("taxon_id") REFERENCES "Taxon" ("id");

ALTER TABLE "OccurrenceIdentification" ADD FOREIGN KEY ("occurrence_id") REFERENCES "Occurrence" ("id");

ALTER TABLE "TaxonInteraction" ADD FOREIGN KEY ("resource_id") REFERENCES "Record" ("id");

ALTER TABLE "TaxonInteraction" ADD FOREIGN KEY ("related_resource_id") REFERENCES "Record" ("id");

COMMENT ON TABLE "Record" IS 'Registro general, puedes ser un taxón o un registro biológico.';

COMMENT ON TABLE "Taxon" IS 'Guarda la información acerca de un taxón';

COMMENT ON TABLE "Occurrence" IS 'Concepto de registro biológico

Para nosotros este guardará los datos de fecha de colecta e lugar de colecta';

COMMENT ON TABLE "MoF" IS 'Tabla de características';

COMMENT ON TABLE "MediaItem" IS 'Se guarda la informacion de los archivos multimedia asociados a un registro';

COMMENT ON COLUMN "MediaItem"."identifier" IS 'URI al recurso: Naturalista link y artículo DOI';

COMMENT ON COLUMN "MediaItem"."type" IS 'Actualmente solo usaremos Image y Text';

COMMENT ON COLUMN "MediaItem"."dc_source" IS 'Aqui podemos guardar la referencia al articulo';

COMMENT ON COLUMN "MediaItem"."publisher" IS 'Para naturalista es Naturalista';

COMMENT ON COLUMN "MediaItem"."licenseUrl" IS 'fundamental en Naturalista';

COMMENT ON COLUMN "MediaItem"."format" IS 'para naturalista son image/jpeg';

COMMENT ON TABLE "CollectionItem" IS 'Se guarda la informacion del ejemplar colectado asociado a un registro';

COMMENT ON TABLE "OccurrenceIdentification" IS 'Asocia el registro biológico con sus identificaciones';

COMMENT ON TABLE "TaxonInteraction" IS 'Registro de interaccion entre taxones';

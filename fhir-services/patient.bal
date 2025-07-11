// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

//
// AUTO-GENERATED FILE.
//
// This file is auto-generated by Ballerina.
// Developers are allowed to modify this file as per the requirement.

import ballerina/http;
import ballerinax/health.fhir.r4;
import ballerinax/health.fhirr4;
import ballerinax/health.fhir.r4.parser as fhirParser;
import ballerinax/health.fhir.r4.uscore311;

# Generic type to wrap all implemented profiles.
# Add required profile types here.
# public type Patient r4:Patient|<other_Patient_Profile>;
public type Patient uscore311:USCorePatientProfile;

configurable boolean enableLegacyBackend = false;

# A service representing a network-accessible API
# bound to port `9099`.
service /fhir/r4 on new fhirr4:Listener(9099, patientApiConfig) {

    // Read the current state of single resource based on its id.
    isolated resource function get Patient/[string id](r4:FHIRContext fhirContext) returns Patient|r4:OperationOutcome|r4:FHIRError|error {
        lock {
            json[] data = check retrievePatientData("Patient").ensureType();
            foreach json val in data {
                map<json> fhirResource = check val.ensureType();
                if (fhirResource.resourceType == "Patient" && fhirResource.id == id) {
                    Patient patient = check fhirParser:parse(fhirResource, uscore311:USCorePatientProfile).ensureType();
                    return patient.clone();
                }
            }
        }
        return r4:createFHIRError("Not found", r4:ERROR, r4:INFORMATIONAL, httpStatusCode = http:STATUS_NOT_FOUND);
    }

    // Read the state of a specific version of a resource based on its id.
    isolated resource function get Patient/[string id]/_history/[string vid](r4:FHIRContext fhirContext) returns Patient|r4:OperationOutcome|r4:FHIRError {
        return r4:createFHIRError("Not implemented", r4:ERROR, r4:INFORMATIONAL, httpStatusCode = http:STATUS_NOT_IMPLEMENTED);
    }

    // Search for resources based on a set of criteria.
    isolated resource function get Patient(r4:FHIRContext fhirContext) returns r4:Bundle|r4:OperationOutcome|r4:FHIRError|error {
        lock {
            return filterPatientData(fhirContext);
        }
    }

    // Create a new resource.
    isolated resource function post Patient(r4:FHIRContext fhirContext, Patient procedure) returns Patient|r4:OperationOutcome|r4:FHIRError {
        return r4:createFHIRError("Not implemented", r4:ERROR, r4:INFORMATIONAL, httpStatusCode = http:STATUS_NOT_IMPLEMENTED);
    }

    // Update the current state of a resource completely.
    isolated resource function put Patient/[string id](r4:FHIRContext fhirContext, Patient patient) returns Patient|r4:OperationOutcome|r4:FHIRError {
        return r4:createFHIRError("Not implemented", r4:ERROR, r4:INFORMATIONAL, httpStatusCode = http:STATUS_NOT_IMPLEMENTED);
    }

    // Update the current state of a resource partially.
    isolated resource function patch Patient/[string id](r4:FHIRContext fhirContext, json patch) returns Patient|r4:OperationOutcome|r4:FHIRError {
        return r4:createFHIRError("Not implemented", r4:ERROR, r4:INFORMATIONAL, httpStatusCode = http:STATUS_NOT_IMPLEMENTED);
    }

    // Delete a resource.
    isolated resource function delete Patient/[string id](r4:FHIRContext fhirContext) returns r4:OperationOutcome|r4:FHIRError {
        return r4:createFHIRError("Not implemented", r4:ERROR, r4:INFORMATIONAL, httpStatusCode = http:STATUS_NOT_IMPLEMENTED);
    }

    // Retrieve the update history for a particular resource.
    isolated resource function get Patient/[string id]/_history(r4:FHIRContext fhirContext) returns r4:Bundle|r4:OperationOutcome|r4:FHIRError {
        return r4:createFHIRError("Not implemented", r4:ERROR, r4:INFORMATIONAL, httpStatusCode = http:STATUS_NOT_IMPLEMENTED);
    }

    // Retrieve the update history for all resources.
    isolated resource function get Patient/_history(r4:FHIRContext fhirContext) returns r4:Bundle|r4:OperationOutcome|r4:FHIRError {
        return r4:createFHIRError("Not implemented", r4:ERROR, r4:INFORMATIONAL, httpStatusCode = http:STATUS_NOT_IMPLEMENTED);
    }

    // post search request
    isolated resource function post Patient/_search(r4:FHIRContext fhirContext) returns r4:FHIRError|http:Response {
        r4:Bundle|error result = filterPatientData(fhirContext);
        if result is r4:Bundle {
            http:Response response = new;
            response.statusCode = http:STATUS_OK;
            response.setPayload(result.clone().toJson());
            return response;
        } else {
            return r4:createFHIRError("Internal Server Error", r4:ERROR, r4:INFORMATIONAL, httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR);
        }
    }
}

isolated function filterPatientData(r4:FHIRContext fhirContext) returns r4:Bundle|error {

    boolean isSearchParamAvailable = false;
    r4:StringSearchParameter[] idParam = check fhirContext.getStringSearchParameter("_id") ?: [];
    r4:StringSearchParameter[] nameParam = check fhirContext.getStringSearchParameter("name") ?: [];
    r4:TokenSearchParameter[] genderParam = check fhirContext.getTokenSearchParameter("gender") ?: [];
    r4:TokenSearchParameter[] identifierParam = check fhirContext.getTokenSearchParameter("identifier") ?: [];

    string[] ids = [];
    foreach r4:StringSearchParameter item in idParam {
        string id = check item.value.ensureType();
        ids.push(id);
    }
    string[] names = [];
    foreach r4:StringSearchParameter item in nameParam {
        string id = check item.value.ensureType();
        names.push(id);
    }
    string[] genders = [];
    foreach r4:TokenSearchParameter item in genderParam {
        string id = check item.code.ensureType();
        genders.push(id);
    }
    string[] identifiers = [];
    foreach r4:TokenSearchParameter item in identifierParam {
        string id = check item.code.ensureType();
        identifiers.push(id);
    }

    r4:TokenSearchParameter[] revIncludeParam = check fhirContext.getTokenSearchParameter("_revinclude") ?: [];
    string revInclude = revIncludeParam != [] ? check revIncludeParam[0].code.ensureType() : "";

    lock {

        r4:Bundle bundle = {identifier: {system: ""}, 'type: "searchset", entry: []};
        r4:BundleEntry bundleEntry = {};
        int count = 0;

        // filter by id
        json[] data = check retrievePatientData("Patient").ensureType();
        json[] resultSet = data;
        if (ids.length() > 0) {
            resultSet = [];
            isSearchParamAvailable = true;
            foreach json val in data {
                map<json> fhirResource = check val.ensureType();
                if fhirResource.hasKey("id") {
                    string id = check fhirResource.id.ensureType();
                    if (fhirResource.resourceType == "Patient" && ids.indexOf(id) > -1) {
                        resultSet.push(fhirResource);
                        continue;
                    }
                }
            }
        }

        // filter by identifier
        json[] identifierFilteredData = [];
        if (identifiers.length() > 0) {
            isSearchParamAvailable = true;
            foreach json val in resultSet {
                map<json> fhirResource = check val.ensureType();
                if fhirResource.hasKey("identifier") {
                    json[] identifierResource = check fhirResource.identifier.ensureType();
                    foreach json identifier in identifierResource {
                        map<json> identifierObject = check identifier.ensureType();
                        string value = check identifierObject.value.ensureType();
                        if (fhirResource.resourceType == "Patient" && identifiers.indexOf(value) > -1) {
                            identifierFilteredData.push(fhirResource);
                            continue;
                        }
                    }
                }
            }
            resultSet = identifierFilteredData;
        }

        // filter by name
        json[] nameFilteredData = [];
        if (names.length() > 0) {
            isSearchParamAvailable = true;
            foreach json val in resultSet {
                map<json> fhirResource = check val.ensureType();
                if fhirResource.hasKey("name") {
                    json[] nameResources = check fhirResource.name.ensureType();
                    foreach json nameResource in nameResources {
                        map<json> nameObject = check nameResource.ensureType();
                        string family = check nameObject.family.ensureType();
                        if (fhirResource.resourceType == "Patient" && names.indexOf(family) > -1) {
                            nameFilteredData.push(fhirResource);
                            continue;
                        }

                    }
                }
            }
            resultSet = nameFilteredData;
        }

        // filter by gender
        json[] genderFilteredData = [];
        if (genders.length() > 0) {
            isSearchParamAvailable = true;
            foreach json val in resultSet {
                map<json> fhirResource = check val.ensureType();
                if fhirResource.hasKey("gender") {
                    string gender = check fhirResource.gender.ensureType();
                    if (fhirResource.resourceType == "Patient" && genders.indexOf(gender) > -1) {
                        genderFilteredData.push(fhirResource);
                        continue;
                    }
                }
            }
            resultSet = genderFilteredData;
        }

        resultSet = isSearchParamAvailable ? resultSet : data;
        foreach json item in resultSet {
            bundleEntry = {fullUrl: "", 'resource: item};
            bundle.entry[count] = bundleEntry;
            count += 1;
        }

        if bundle.entry != [] {
            return addRevInclude(revInclude, bundle, count, "Patient").clone();
        }
        return bundle.clone();
    }
}

// Retrieve data from the backend
isolated function retrievePatientData(string resourceType) returns json|error {

    string resourcePath = enableLegacyBackend ? "/data/legacy/" + resourceType : "/data/" + resourceType;
    http:Response response = check backendClient->get(resourcePath);
    if response.statusCode == http:STATUS_OK {
        json[] payload = check response.getJsonPayload().ensureType();
        if enableLegacyBackend {
            json[] fhirPayload = [];
            foreach json item in payload {
                LegacyPatient legacyPatientRecord = check item.cloneWithType();
                uscore311:USCorePatientProfile patient = check transform(legacyPatientRecord).ensureType();
                fhirPayload.push(patient.toJson());
            }
            return fhirPayload;
        }
        return payload.toJson();
    } else {
        return error("Failed to retrieve data from backend service");
    }
}

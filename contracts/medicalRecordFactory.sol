// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./medicalRecord.sol";

contract MedicalRecordFactory {
    address public hospitalManagement;
    address[] public deployedMedicalRecords;

    modifier onlyHospitalManagement() {
        require(
            msg.sender == hospitalManagement,
            "Only hospital management can create a record"
        );
        _;
    }

    event MedicalRecordCreated(
        address indexed patientAddress,
        address indexed medicalRecordContract
    );

    constructor() {
        hospitalManagement = msg.sender;
    }

    function setHospitalManagement(address newManagement)
        external
        onlyHospitalManagement
    {
        hospitalManagement = newManagement;
    }

    event Debug(address sender, address hospitalManagement, bool condition);

    function createMedicalRecord(
        address _patientAddress,
        string memory _name,
        uint256 _age,
        string memory _dateOfBirth,
        string memory _sex,
        string memory _condition
    ) external onlyHospitalManagement {
        emit Debug(
            msg.sender,
            hospitalManagement,
            msg.sender == hospitalManagement
        );

        MedicalRecord newRecord = new MedicalRecord();
        emit MedicalRecordCreated(address(newRecord), msg.sender);

        newRecord.createMedicalRecord(
            _patientAddress,
            _name,
            _age,
            _dateOfBirth,
            _sex,
            _condition
        );

        deployedMedicalRecords.push(address(newRecord));

        emit MedicalRecordCreated(_patientAddress, address(newRecord));
    }

    function getDeployedMedicalRecords()
        external
        view
        returns (address[] memory)
    {
        return deployedMedicalRecords;
    }

    function getAllPatientsFromRecord(address recordAddress) public view returns (MedicalRecord.Patient[] memory) {
        MedicalRecord record = MedicalRecord(recordAddress);
        return record.getAllPatients();
    }

    function getPatientFromRecordByIndex(address recordAddress, uint256 index) public view returns (MedicalRecord.Patient memory) {
        MedicalRecord record = MedicalRecord(recordAddress);
        return record.getPatientByIndex(index);
    }
}

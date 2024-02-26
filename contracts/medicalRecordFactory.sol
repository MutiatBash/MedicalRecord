// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./medicalRecord.sol";

contract MedicalRecordFactory {
    address public hospitalManagement;
    address[] public deployedMedicalRecords;

    modifier onlyHospitalManagement() {
        require(msg.sender == hospitalManagement, "Only hospital management can call this function");
        _;
    }

    event MedicalRecordCreated(address indexed patientAddress, address indexed medicalRecordContract);

    constructor() {
        hospitalManagement = msg.sender;
    }

    function setHospitalManagement(address newManagement) external onlyHospitalManagement {
        hospitalManagement = newManagement;
    }

    function createMedicalRecord(
        address _patientAddress,
        string memory _name,
        uint256 _age,
        string memory _dateOfBirth,
        string memory _sex,
        string memory _initialCondition
    ) external onlyHospitalManagement {

        MedicalRecord newRecord = new MedicalRecord(
           hospitalManagement
        );
        emit MedicalRecordCreated(address(newRecord), msg.sender);

        newRecord.createMedicalRecord(_patientAddress, _name, _age, _dateOfBirth, _sex, _initialCondition);

        deployedMedicalRecords.push(address(newRecord));

        emit MedicalRecordCreated(_patientAddress, address(newRecord));
    }

    function getDeployedMedicalRecords() external view returns (address[] memory) {
        return deployedMedicalRecords;
    }
}

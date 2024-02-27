// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract MedicalRecord {
    address public hospitalManagement;

    // modifier onlyHospitalManagement() {
    //     require(msg.sender == hospitalManagement, "Only hospital management can call this function");
    //     _;
    // }

    struct Patient {
        address patientAddress;
        string name;
        uint256 age;
        string dateOfBirth;
        string sex;
        string condition;
    }

    Patient[] public patients;

    event ConditionUpdated(address indexed patientAddress, string newCondition);

    // constructor(address _hospitalManagement) {
    //     hospitalManagement = _hospitalManagement;
    // }

    function createMedicalRecord(
        address _patientAddress,
        string memory _name,
        uint256 _age,
        string memory _dateOfBirth,
        string memory _sex,
        string memory _condition
    ) external {
        patients.push(Patient({
            patientAddress: _patientAddress,
            name: _name,
            age: _age,
            dateOfBirth: _dateOfBirth,
            sex: _sex,
            condition: _condition
        }));
    }

    function updateCondition(address _patientAddress, string memory newCondition) external {
        for (uint256 i = 0; i < patients.length; i++) {
            if (patients[i].patientAddress == _patientAddress) {
                patients[i].condition = newCondition;
                emit ConditionUpdated(_patientAddress, newCondition);
                break;
            }
        }
    }

    function getCondition(address _patientAddress) external view returns (string memory) {
        for (uint256 i = 0; i < patients.length; i++) {
            if (patients[i].patientAddress == _patientAddress) {
                return patients[i].condition;
            }
        }
        return "";
    }
}

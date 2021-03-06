pragma solidity ^0.4.24;

contract Caducee {

  // A Doctor writes a prescription for his patient
  event WritePrescription(
    address indexed doctor,
    address indexed patient,
    string prescriptionHash
  );

  // A Pharmacist can write a followup, with info about what was brought
  event WriteFollowup(
    address indexed patient,
    string followupHash
  );

  address public owner;
  mapping(address => bool) public doctors;
  mapping(address => bool) public pharmacies;

  modifier isOwner() { require(msg.sender == owner); _; }
  modifier isDoctor() { require(doctors[msg.sender]); _; }
  modifier isPharmacy() { require(pharmacies[msg.sender]); _; }

  constructor() public {
    owner = msg.sender;
    // For test purposes:
    addDoctor(0xf17f52151EbEF6C7334FAD080c5704D77216b732);
    addPharmacy(0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef);
  }

  function addDoctor(address doctor) public isOwner() {
    doctors[doctor] = true;
  }

  function removeDoctor(address doctor) public isOwner() {
    doctors[doctor] = false;
  }

  function addPharmacy(address pharmacy) public isOwner() {
    pharmacies[pharmacy] = true;
  }

  function removePharmacy(address pharmacy) public isOwner() {
    pharmacies[pharmacy] = false;
  }

  function writePrescription(address doctor, address patient, string prescriptionHash) public isDoctor() {
    emit WritePrescription(doctor, patient, prescriptionHash);
  }

  function writeFollowup(address patient, string followupHash) public isPharmacy() {
    emit WriteFollowup(patient, followupHash);
  }
}

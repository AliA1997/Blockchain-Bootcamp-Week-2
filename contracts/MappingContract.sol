pragma solidity ^0.8.4;

contract MappingContract {
    
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    mapping(uint => mapping(uint => bool)) public nestedUintMapping;
    
    function setValue(uint _index)  public {
        myMapping[_index] = true;
    }
    
    function setAddressMapping() public {
        myAddressMapping[msg.sender] = true;
    }
    
    function setNestedUintMapping(uint _parentIndex, uint _childIndex) public {
        nestedUintMapping[_parentIndex][_childIndex] = true;
    }
}
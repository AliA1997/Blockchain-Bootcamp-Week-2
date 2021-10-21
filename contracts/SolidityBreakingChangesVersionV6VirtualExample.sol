pragma solidity 0.6.1;

contract SolidityBreakingChangesVersion6ViritualExample {

    uint someUint;
    
    function fun() public virtual {
        someUint = 5;
    }
}
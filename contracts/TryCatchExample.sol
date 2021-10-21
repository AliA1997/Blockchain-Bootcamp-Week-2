pragma solidity ^0.8.1;


contract WillThrow {
    function aFunction() public {
        require(false, "Error Message");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason);
    
    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            //If the aFunction works do something.
        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
    }
}
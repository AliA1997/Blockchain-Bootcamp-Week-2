pragma solidity ^0.8.1;

contract StructMappingContract {
    
    struct Payment {
        uint amount;
        uint timestamp;
    }
    
    struct Balance {
        uint totalAmount;
        uint numOfPayments;
        mapping(uint => Payment) payments;
    }
    
    mapping(address => Balance) public balancesReceived;
    
    function receiveMoney() public payable {
        Payment memory payment = Payment(msg.value, block.timestamp);
        balancesReceived[msg.sender].totalAmount += msg.value;
    }
    
    function sendMoney() public payable {
        balancesReceived[msg.sender].totalAmount += msg.value;
        Payment memory payment = Payment(msg.value, block.timestamp);
        
        balancesReceived[msg.sender].payments[balancesReceived[msg.sender].numOfPayments] = payment;
        balancesReceived[msg.sender].numOfPayments++;
    }
    
    function getContractAccountBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function getEOABalance() public view returns (uint) {
        return balancesReceived[msg.sender].totalAmount;
    }
    
    function withdrawAllMoney(address payable _to) public {
        require(balancesReceived[msg.sender].totalAmount > 0, "No money in eoa.(Externally owned account.)");
        uint amountToSend = balancesReceived[msg.sender].totalAmount;
        balancesReceived[msg.sender].totalAmount = 0;
        _to.transfer(amountToSend);
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(balancesReceived[msg.sender].totalAmount >= _amount, "Not enough funds");
        balancesReceived[msg.sender].totalAmount -= _amount;
        _to.transfer(_amount);
    }
}
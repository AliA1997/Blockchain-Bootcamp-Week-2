pragma solidity 0.5.3;

contract FunctionsExample {
    mapping(address => uint) public balanceReceived;
    
    address payable owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function getOwner() public view returns(address) {
        return owner;
    }
    
    function destroySmartContract() public {
        require(msg.sender == owner, "You must be the owner to destroy the smart contract");
        selfdestruct(msg.sender);
    }
    
    //Pure function does not interact with class variables, only within scope of pure function, and the use of other pure functions.
    //Cannot use view function, view function can call pure function though.
    function convertWeiToEther(uint _amountOfWei) public pure returns(uint) {
        return _amountOfWei / 1 ether;
    }
    
    function convertEtherToWei(uint _amountOfEther) public pure returns(uint) {
        //return _amountOfEther * (10 ** 18);
        return _amountOfEther * (10 ** 18 wei) ;
    }
    
    function receiveMoney() public payable {
        //Prevent unexpected input such as the balance + msg.value being greater than the current balance.
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        //If the amount is not less than or equal to the balance of address withdrawing money, then throw an exception message of not enough funs and revert transaction(preserve the rest of the gas that would've been spent)
        require(_amount <= balanceReceived[msg.sender], "not enough funds");
        //Prevent unexpected input such as a integar being wrapped around.(5 - 10 = 250 not -5)
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        //Transfer amount.
        _to.transfer(_amount);
    }
    
    //Fallback function 
    function () external payable {
        receiveMoney();
    }
}
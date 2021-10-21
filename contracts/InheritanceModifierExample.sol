pragma solidity 0.8.1;
import "./Owned.sol";

contract InheritanceModifierExample is Owned {
    
    mapping(address => uint) public tokenBalance;
    
    uint tokenPrice = 1 ether;
    
    event TokensSend(address _from, address _to, uint _amount);
    
    
    constructor() public {
        tokenBalance[owner] = 100;
    }
    
    // Can centralize this functionality into a mmodifier
    function createNewToken() public onlyOwner {
        
        tokenBalance[owner]++;
    }
    
    function burnToken() public onlyOwner {
        
        tokenBalance[owner]--;
    }
    
    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }
    
    function sendToken(address _to, uint _amount) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
            // assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
            // assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        emit TokensSend(msg.sender, _to, _amount);
        return true;
    }
}
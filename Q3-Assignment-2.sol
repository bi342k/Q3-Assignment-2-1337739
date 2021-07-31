//Name: Muhammad Irfan
//Roll No: PIAIC1337739
pragma solidity ^0.8.0;
contract myBank{
    
    address Owner;
    address contAddress;
    mapping(address => uint256) private balance;
    uint8 private CountClient;
    
    constructor () payable {
        require(msg.value >= 50 ether, "Minimum deposit must be 50 ether");
        Owner = msg.sender;
        CountClient = 0;
        contAddress = address(this);
        
    }
    
    modifier onlyOwner (address _Account){
        require(_Account == Owner, "You are not Owner");
            _;
    }
    
    event depositMade (address indexed _Depositor, uint256 _Amount);
    
    function OpenAccount () public payable returns(uint256 _Balance){
        require(msg.value > 0, "Please deposit some amount to open an account");
        require(balance[msg.sender] <= 0, "You have already opened an account");
        balance[msg.sender] += msg.value;
        if (CountClient < 6){
                CountClient++;
                balance[msg.sender] += 1 ether;
        }
        
        return balance[msg.sender]; 
              
    }
    
    function Deposit() public payable returns(uint256){
        require(msg.value > 0, "You have not entered any amount");
        require(balance[msg.sender] > 0, "You have not yet opened an account");
        balance[msg.sender] += msg.value;
        emit depositMade(msg.sender, msg.value);
        return balance[msg.sender];
    }
    
    function Withdraw(address payable _SendTo, uint256 _WithdrawAmount) public returns(uint256){
        _WithdrawAmount = _WithdrawAmount*(10**18);
        require(balance[msg.sender] >= _WithdrawAmount, "Not enough balance in the account or don not have account");
        balance[msg.sender] -= _WithdrawAmount;
        _SendTo.transfer(_WithdrawAmount);
        
        return balance[msg.sender];
    }
    
    function CheckBalance () public view returns (uint256){
        return balance[msg.sender];
    }
    
    function BankBalance () public view returns(uint){
        return address(this).balance;
    }
    
    function CloseBank(address payable _Owner) public payable onlyOwner(_Owner){
       selfdestruct(_Owner);
    }
    
}

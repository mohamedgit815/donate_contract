// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract BankDapp {
    address private _owner; 
    mapping(address=>uint256) private _mapUsers;

    constructor() {
        _owner = msg.sender;
    }

    function mint( address payable users_ ) external payable {
        uint256 valuePrice = msg.value;
        address sender = msg.sender;
        uint256 priceNumber = _mapUsers[users_] + msg.value;

        require(sender != address(0) && _owner != address(0) && users_ != address(0)  ,"Your Address is 0");
        require(sender == _owner,"You cant Send Money to Peaple");
        require(users_ != _owner,"You are Owener");
        require(valuePrice > 0 , "The Money must be bigger Zero Than");
        require(_mapUsers[users_] < 1000000000000000000,"The Users Have Max Money");
        require(valuePrice<= 1000000000000000000,"The money is Bigger");
        require(priceNumber <= 1000000000000000000,"Your Money is Full");

        _mapUsers[users_] += valuePrice;
        users_.transfer(valuePrice);
    }

    function getOwner() external view returns(address) {
        return _owner;
    } 

    function getPriceUsers( address users_ ) external view returns(uint256) {
        return _mapUsers[users_];
    }

    function getResultPrice( address users_ ) external view returns(uint256) {
        return 1000000000000000000 - _mapUsers[users_];
    }    


    function sendMoney() external payable {
        uint256 valuePrice = msg.value;
        address sender = msg.sender;
        uint256 priceNumber = valuePrice - _mapUsers[sender];
        
        require(sender != address(0) && _owner != address(0)  ,"Your Address is 0");
        require(valuePrice > 0 , "The Money must be bigger Zero Than");
        require(priceNumber >= 0 , "You don't have any Money");
        require(sender != _owner,"You are Owener");

        _mapUsers[sender] -= valuePrice;
        payable(_owner).transfer(valuePrice);
    }

}
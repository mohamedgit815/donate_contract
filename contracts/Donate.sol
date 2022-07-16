// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;


contract DonateDapp {
    //address payable test = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;

    //1: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    //2: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

    mapping (address => uint256 []) private _usersMap;
    uint256 private _count = 0;

    modifier existUsers {
        require(msg.sender != address(0),"Check your Address");
         _;
    }

    
    function donate() external payable existUsers {
       // require(msg.sender != address(0),"Check your Address");
        require(msg.value >= 1000000000000000000,"Your Gas is Little");
        uint256 count_ = _count++;

        _usersMap[msg.sender].push(count_);

        payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2).transfer(msg.value);
    }

    function getDonate(address userAddress_) external view returns(uint256 [] memory) {
        require(userAddress_ != address(0),"Check your Address");
        return _usersMap[userAddress_];
    }

    function getDonateLength(address userAddress_) external view returns(uint256) {
        require(userAddress_ != address(0),"Check your Address");
        return _usersMap[userAddress_].length;
    }

}
pragma solidity ^0.4.18;

contract devent {
  uint256 public totalRised;
  uint256 softCap;
  uint256 hardCap;
  uint256 deadLine;

  mapping(address => uint256) balances;

  function devent(uint _softCap, uint _hardCap, uint _deadLine ) public {
      softCap = _softCap;
      hardCap = _hardCap;
      deadLine = _deadLine;
  }

  function () payable {
      require(now < deadLine);
      balances[msg.sender] = msg.value;
  }

  function balanceOf(address _owner) public constant returns (uint256 balance) {
    return balances[_owner];
  }


}

contract master {

    mapping (uint => address) internal ev_contracts;
    devent d_contract;

    function master() public {

    }

    function create_devent(uint _deventId, uint _softcap, uint _hardcap,  uint _deadLine) returns (address _devent){
        ev_contracts[_deventId] = address(  new devent(_softcap, _hardcap, _deadLine) );
        return ev_contracts[_deventId];
    }
    function deventById(uint _deventId) public constant returns (address _devent) {
        return ev_contracts[_deventId];
  }
}
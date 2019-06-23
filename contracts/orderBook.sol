pragma solidity >=0.4.22 <0.6.0;

contract orderBook {

    struct SellOrder {
    address producer;
    uint32 day;
    uint32 price;
    uint64 energy;
    uint64 timestamp;
  }

  struct BuyOrder {
    address producer;
    uint32 day;
    uint32 price;
    uint64 energy;
    address meterAddress;
    uint64 timestamp;
  }

  SellOrder[] public sellOrders;
  BuyOrder[] public buyOrders;

  mapping(address => uint) public sellIndex;

  event sellEvent(address indexed producer, uint32 indexed day, uint32 indexed price, uint64 energy);
  event buyEvent(address indexed producer, uint32 indexed day, uint32 price, uint64 energy, address meterAddress);

  function sellEnergy(uint32 aday, uint32 aprice, uint64 aenergy, uint64 atimestamp) public {

    require(aenergy >= 1);

    uint idx = sellIndex[msg.sender];

    sellOrders.push(SellOrder({
      producer: msg.sender,
      day: aday,
      price: aprice,
      energy: aenergy,
      timestamp: atimestamp
      }));
    emit sellEvent(sellOrders[idx].producer, sellOrders[idx].day, sellOrders[idx].price, sellOrders[idx].energy);
  }

  function buyEnergy(address aproducer, uint32 aday, uint32 aprice, uint64 aenergy, address mAddress, uint64 atimestamp) internal {

    uint idx = sellIndex[aproducer];

    if ((sellOrders.length > idx) && (sellOrders[idx].producer == aproducer)) {

      require(sellOrders[idx].price == aprice);

      buyOrders.push(BuyOrder({
        producer: aproducer,
        day: aday,
        price: aprice,
        energy: aenergy,
        meterAddress: mAddress,
        timestamp: atimestamp
        }));
      emit buyEvent(aproducer, aday, aprice, aenergy, mAddress);
    } else {
      revert();
    }
  }

}

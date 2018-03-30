pragma solidity ^0.4.13;

contract EcommerceStore {
  enum ProductStatus { Open, Sold, Unsold }
  enum ProductCondition { New, Used }

  struct Product {
    uint id;
    string name;
    string category;
    string imageLink;
    string descLink;
    uint auctionStartTime;
    uint auctionEndTime;
    uint startPrice;
    address highestBidder;
    uint highestBid;
    uint secondHighestBid;
    uint totalBids;
    ProductStatus status;
    ProductCondition condition;
  }  
  
  mapping (address => mapping(uint => Product)) stores;
  mapping (uint => address) productIdInStore;  
  uint public productIndex;

  function EcommerceStore() public {
    productIndex = 0;
  }

  function addProductToStore(string _name, string _category, string _imageLink, 
    string _descLink, uint _auctionStartTime,
    uint _auctionEndTime, uint _startPrice, uint _productCondition) public {
    require (_auctionStartTime < _auctionEndTime);
    productIndex += 1;
    Product memory product = Product(productIndex, _name, _category, _imageLink, _descLink, _auctionStartTime, _auctionEndTime,
                     _startPrice, 0, 0, 0, 0, ProductStatus.Open, ProductCondition(_productCondition));

    stores[msg.sender][productIndex] = product;
    productIdInStore[productIndex] = msg.sender;    
  }  
  
  function getProduct(uint _productId) view public returns (uint, string, string, string, string, uint, uint, uint, ProductStatus, ProductCondition) {
    Product memory product = stores[productIdInStore[_productId]][_productId];
    return (product.id, product.name, product.category, product.imageLink, product.descLink, product.auctionStartTime,
        product.auctionEndTime, product.startPrice, product.status, product.condition);
  }   
}

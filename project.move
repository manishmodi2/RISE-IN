module MyModule::SupplyChainTracking {
    use aptos_framework::signer;

    struct Product has store, key {
        id: u64,
        owner: address,
        location: vector<u8>,
    }

    /// Function to register a new product in the supply chain.
    public fun register_product(owner: &signer, id: u64, location: vector<u8>) {
        let product = Product {
            id,
            owner: signer::address_of(owner),
            location,
        };
        move_to(owner, product);
    }

    /// Function to update the location of an existing product.
    public fun update_location(owner: &signer, id: u64, new_location: vector<u8>) acquires Product {
        let product = borrow_global_mut<Product>(signer::address_of(owner));
        assert!(product.id == id, 1); // Ensure the product ID matches

        // Update the product's location
        product.location = new_location;
    }
}

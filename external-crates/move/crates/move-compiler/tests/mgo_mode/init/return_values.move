// init cannot have return values
module a::m {
    use mgo::tx_context;
    fun init(_: &mut tx_context::TxContext): u64 {
        0
    }
}

module mgo::tx_context {
    struct TxContext has drop {}
}

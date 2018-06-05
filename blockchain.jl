using SHA

# Individual block structure
struct Block
    index::Int
    timestamp::DateTime
    data::String
    previous_hash::String
    hash::String
    # Constructor which also creates hash for the block, with
    # 256 bit encryption for the blockchain's security needs
    function Block(index, timestamp, data, previous_hash)
        hash = sha2_256(string(index, timestamp, data, previous_hash))
        new(index, timestamp, data, previous_hash, bytes2hex(hash))
    end
end

# Add another block to the chain, which needs more than one block
function next_block(tail_block::Block)
    new_index = tail_block.index + 1
    return Block(new_index, Dates.now(), string("This is block ",new_index), tail_block.hash)
end

# Create the special first block or the head of the blockchain
Blockchain = [Block(0, Dates.now(), "Genesis Block", "0")]
println("Genesis Block : 1")
println("Hash :", Blockchain[1].hash)

# Size of the blockchain
Blockchain_limit = 13

# To make non-arbitary addition of blocks to blockchain (unlike here),
# a proof of work task is required
for tail = 1:Blockchain_limit
    # Link the new block to the chain
    append!(Blockchain, [next_block(Blockchain[tail])])
    # The details of the block
    println("Block : $(tail+1)")
    println("Hash :", Blockchain[tail+1].hash)
end

"""
Block : 2
Hash :cf00fbdedd5718c54a07ade6c5dd682b6b353c8b97ed04ec6214516b856d33fe
Block : 3
Hash :fac28de5fa97a557f13c0dc40102dfb53884b7af06f31cd86f08475ff4761efd
Block : 4
Hash :db221bca51d7532a091f75f1f73771cc790f66956c2fb6a23793e4dc207fa1e6
Block : 5
Hash :c260fa19272c62d9e74ad45bc5f2491c32a249f37db1527cbb72f0eb153c2dbf
Block : 6
Hash :4cb27d7cdd35332f84c14783ad9dc992662fa3cfd7bbe42d66f4016e03d9911c
Block : 7
Hash :9267d4c271c9d5bf153a9271f89ac8a1d80e48d31e85bbb860a678eb016d34df
Block : 8
Hash :2641d9f186a7695a5e74f2d45f3a48675f6ae00c03011e51d1358830c66e6ab6
Block : 9
Hash :4f47d38eb66bd544de417e036f2755c931105357192a4257afd9bec3b578124a
Block : 10
Hash :d8c936fc5a88b63ef8bfcb014795c4d5247c1343bdde25c968335eb1913743be
Block : 11
Hash :39c1ce64f197a3a253e4dfa37a0bfda59ed393d4ddcdac827f8720f012745c2b
Block : 12
Hash :9fcfe352ae6f1c2bc43faa5cd7463de61cb95de7e1c59e7271b133ab80dc4d59
Block : 13
Hash :ab9063712f8124c0ae22c43fa40428b4f0e9bb8b0f98548d5a6d4798375d8dba
Block : 14
Hash :eb60d95b342257422ceb9d5ddeba02e6ec1096c87c74385be0ad41c7dba6f056
"""

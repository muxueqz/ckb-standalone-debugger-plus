#!/usr/bin/env ruby

require "rbnacl"

def bin_to_hex(bin)
  "0x#{bin.unpack1('H*')}"
end

def blake2b(data)
  RbNaCl::Hash::Blake2b.digest(data,
                               personal: "ckb-default-hash",
                               digest_size: 32)
end

if ARGV.length != 2
  STDERR.puts "Usage: runner.rb <script file> <witness args>"
  exit 1
end

script_binary = File.read(ARGV[0])
script_hash = blake2b(script_binary)

tx = DATA.read.sub("@FIB_CODE", bin_to_hex(script_binary))
       .sub("@FIB_HASH", bin_to_hex(script_hash))
       .sub("@FIB_ARG", ARGV[1])

File.write("tx.json", tx)
commandline = "/opt/debugger/ckb-debugger --tx-file tx.json --script-group-type type -i 0 -e input"
STDERR.puts "Executing: #{commandline}"
exec(commandline)

__END__
{
  "mock_info": {
    "inputs": [
      {
        "input": {
          "previous_output": {
            "tx_hash": "0xa98c57135830e1b91345948df6c4b8870828199a786b26f09f7dec4bc27a73da",
            "index": "0x0"
          },
          "since": "0x0"
        },
        "output": {
          "capacity": "0x4b9f96b00",
          "lock": {
            "args": "0x",
            "code_hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "hash_type": "data"
          },
          "type": {
            "args": "0x",
            "code_hash": "@FIB_HASH",
            "hash_type": "data"
          }
        },
        "data": "0x"
      }
    ],
    "cell_deps": [
      {
        "cell_dep": {
          "out_point": {
            "tx_hash": "0xfcd1b3ddcca92b1e49783769e9bf606112b3f8cf36b96cac05bf44edcf5377e6",
            "index": "0x0"
          },
          "dep_type": "code"
        },
        "output": {
          "capacity": "0x702198d000",
          "lock": {
            "args": "0x",
            "code_hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "hash_type": "data"
          },
          "type": null
        },
        "data": "@FIB_CODE"
      }
    ],
    "header_deps": []
  },
  "tx": {
    "version": "0x0",
    "cell_deps": [
      {
        "out_point": {
          "tx_hash": "0xfcd1b3ddcca92b1e49783769e9bf606112b3f8cf36b96cac05bf44edcf5377e6",
          "index": "0x0"
        },
        "dep_type": "code"
      }
    ],
    "header_deps": [
    ],
    "inputs": [
      {
        "previous_output": {
          "tx_hash": "0xa98c57135830e1b91345948df6c4b8870828199a786b26f09f7dec4bc27a73da",
          "index": "0x0"
        },
        "since": "0x0"
      }
    ],
    "outputs": [
      {
        "capacity": "0x0",
        "lock": {
          "args": "0x",
          "code_hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "hash_type": "data"
        },
        "type": null
      }
    ],
    "witnesses": [
      "@FIB_ARG"
    ],
    "outputs_data": [
      "0x"
    ]
  }
}

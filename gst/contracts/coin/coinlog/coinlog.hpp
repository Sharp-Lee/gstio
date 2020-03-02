#include <gstiolib/gstio.hpp>
#include <gstiolib/asset.hpp>
#include <gstiolib/contract.hpp>
#include <gstiolib/crypto.h>
#include <string>

using namespace gstio;
using namespace std;


class coin: public contract { 
public:
        coin(account_name self)
                : contract(self),
            bets(_self, _self),
            hashlist(_self, _self),
            bankers(_self, _self),
            global(_self, _self) {
        }
    // @abi action
    void init();
    // @abi action
    void addhash(checksum256 hash);

    void ontransfer(account_name from, account_name to, extended_asset quantity, std::string memo);
    
    void reveal(account_name player);
    // @abi action
    void update(uint64_t status, asset gst_safe_balance, asset lkt_safe_balance);
    // @abi action
    void clearhash();
    // @abi action
    void withdraw(account_name banker);
    // @abi action
    void sell(uint64_t pos, account_name owner);

private:
    //结果表

   // @abi table global i64
    struct st_result {
    std::string result;   
    account_name player;
    asset bet_amount;
    asset win_amount;
    std::string bet_nums;
    std::string time;
    uint64_t reveal_num;
    uint64_t reveal_time;
};


    // @abi table global i64
    struct global {
        uint64_t id = 0;
        asset gst_safe_balance;
        asset lkt_safe_balance;
        uint64_t status;
        uint64_t queue_size;
        uint64_t primary_key() const { return id; }
        GSTLIB_SERIALIZE(global, (id)(gst_safe_balance)(lkt_safe_balance)(status)(queue_size))
    };
    typedef gstio::multi_index<N(global), global> global_index;
    global_index global;  

    // @abi table bet i64
    struct betitem {
        account_name account;
        checksum256 seed;
        checksum256 house_hash;
        extended_asset bet_amount;
        vector<std::string>  time;
        vector<uint64_t> bet_nums;
        uint64_t primary_key() const { return account; }

      const    extended_asset get_bonus(uint64_t reveal_pos) {
            extended_asset result = bet_amount;
            for (uint64_t i = 0; i < bet_nums.size(); i ++) {
                if (bet_nums[i] == reveal_pos) {
                    result.amount = result.amount * 97 * 6 / ( 100 * bet_nums.size() );
                    return result;
                }
            }
            result.amount = 0;
            return result;
        }

        const string get_bets() {
            std::string res = std::to_string(bet_nums[0]);
            for (uint64_t i = 1; i < bet_nums.size(); i ++) {
                res.append(",");
                res.append(std::to_string(bet_nums[i]));
            }
            return res;
        }
        

        GSTLIB_SERIALIZE(betitem, (account)(seed)(house_hash)(bet_amount)(time)(bet_nums))
    };
    typedef gstio::multi_index<N(bet), betitem> bet_index;
    bet_index bets;

    // @abi table househash i64
    struct househash {
        uint64_t id;
        checksum256 hash;
        uint64_t primary_key() const { return id; }
        GSTLIB_SERIALIZE(househash, (id)(hash))
    };
    typedef gstio::multi_index<N(househash), househash> househash_index;
    househash_index hashlist;

    // @abi table banker i64
    struct banker {
        uint64_t pos;
        account_name owner;
        asset bid;
        asset dividend;
        asset history_dividend;
        uint64_t primary_key() const { return pos; }
        GSTLIB_SERIALIZE(banker, (pos)(owner)(bid)(dividend)(history_dividend))
    };
    typedef gstio::multi_index<N(banker), banker> banker_index;
    banker_index bankers;

    struct exchange_state {
      asset    supply;

      struct connector {
         asset balance;
         double weight;

         GSTLIB_SERIALIZE( connector, (balance)(weight) )
      };

      connector base;
      connector quote;

      uint64_t primary_key()const { return supply.symbol; }

      GSTLIB_SERIALIZE( exchange_state, (supply)(base)(quote) )
    };
    typedef gstio::multi_index<N(tokenmarket), exchange_state> tokenmarket;

    struct token
    {
        token(account_name tkn) : _self(tkn) {}
        struct account
        {
            gstio::asset    balance;
            uint64_t primary_key()const { return balance.symbol.name(); }
        };
        typedef gstio::multi_index<N(accounts), account> accounts;

        asset get_balance(account_name owner,  gstio::symbol_type sym) const
        {
            accounts acnt(_self, owner);
            auto itr = acnt.find( sym.name() );
            if (itr != acnt.end()) {
                return acnt.find(sym.name())->balance;
            } else {
                return asset(0, sym);
            }
        }

    private:
        account_name _self;
    };

    uint64_t merge_seed(const checksum256& s1, const checksum256& s2); 

    void bet(account_name account, const vector<uint64_t> & bet_nums, extended_asset quantity, const checksum256& seed );

    void rock(betitem item);

    asset getlkt(uint64_t amount);

    void bebanker(account_name, extended_asset quantity, uint64_t pos);

    void rewardbanker(uint64_t reveal_pos, uint64_t reward_amount);

    void rewarddev(uint64_t reward_amount);

    void flowbancor(uint64_t flow_amount);

    void flowdivpool(uint64_t amount);

    void buybacklkt(uint64_t amount, account_name player);

    uint8_t char2int(const string& str);

    void string2seed(const string& str, uint64_t time);

    



    void split(std::string str, std::string splitBy, std::vector<std::string>& tokens)
    {
        /* Store the original string in the array, so we can loop the rest
         * of the algorithm. */
        tokens.push_back(str);

        // Store the split index in a 'size_t' (unsigned integer) type.
        size_t splitAt;
        // Store the size of what we're splicing out.
        size_t splitLen = splitBy.size();
        // Create a string for temporarily storing the fragment we're processing.
        std::string frag;
        // Loop infinitely - break is internal.
        while(true)
        {
            /* Store the last string in the vector, which is the only logical
             * candidate for processing. */
            frag = tokens.back();
            /* The index where the split is. */
            splitAt = frag.find(splitBy);
            // If we didn't find a new split point...
            if(splitAt == string::npos)
            {
                // Break the loop and (implicitly) return.
                break;
            }
            /* Put everything from the left side of the split where the string
             * being processed used to be. */
            tokens.back() = frag.substr(0, splitAt);
            /* Push everything from the right side of the split to the next empty
             * index in the vector. */
            tokens.push_back(frag.substr(splitAt+splitLen, frag.size()-(splitAt+splitLen)));
        }
    }
};


# Sk_SQLVariableAPI
easy to save variables to mysql database  
**(warning: set date format to ``yyyy/MM/dd-HH:mm:ss`` in config.sk date variable can be parsed)**


# Version Required
* spigot or paper: 1.13.2 ~ 1.19.3
* skript 2.3.7 ~ 2.6.4


# Addons Required
* skript-db
* skript-reflect
* item NBT API


# API
  * ### write and delete:  
    * #### sqlvar_write(string,object)
      wirte data to variable in database  
      > ex:  
      `sqlvar_write("data::%name of player%",player's tool)`  
    * #### sqlvar_WriteToList(string,object)
      write data to variable list in database  
      > ex:  
      `sqlvar_WriteToList("playerlist",player) -> {playerlist::1} = xxxplayer `
    * #### sqlvar_delete(string)
      delete variable from database  
      > ex:  
      `sqlvar_delete("playerdata::%uuid of player%") -> delete {playerdata::xxx} `
    * #### sqlvar_delete_list(string)
      delete variable list from database 
      > ex:  
      `sqlvar_delete_list("playerdata") -> it will delete {playerdata::*} `

  * ### load:  

    * #### section {function::sqlvar_load} 
      load variable from database
      example:  
      ```
      # in sql {playerdata::%name of player%} -> "hello world"
      run section {function::sqlvar_load} async with arguments "playerdata::%name of player%" and store result in {_output} and wait
      if {_output} != null:
        send "%{_output}%"
      # will print hello world
      ```
     
    * #### section {function::sqlvar_getkeys}
      get index(key) of variable list
      example:  
      ```
      #in sql {test::a::1} = "abc"   {test::b::1} = "zxc"
      run section {function::sqlvar_getkeys} async with arguments "test" and store result in {_output::*} and wait
      loop {_output::*}:
        send loop-value
      # will print:
      #              a
      #              b 
      
      ```
    * #### section {function::sqlvar_getlist}
      load all variable from list
      example:  
      ```
      # in sql {test::a} = "abc"   {test::b} = "zxc"
      run section {function::sqlvar_getlist} async with arguments "test" and store result in {_output::*} and wait

      # {_output::*} ->  a , abc , b , zxc
      # set {_index::*} to sqlvar_list_parsed({_output::*},"index")  ->  a , b
      # set {_value::*} to sqlvar_list_parsed({_output::*},"value")  ->  "abc" , "zxc"
      #
      #  also can use this to get index and value
      #  set {_count} to 1
      #  loop size of {_output::*}/2 times:
      #      set {_list::%{_output::%{_count}%}%} to {_output::%{_count}+1%}
      #      add 2 to {_count}
      #  {_list::a} = abc   {_list::b} = zxc
      
      ```


      

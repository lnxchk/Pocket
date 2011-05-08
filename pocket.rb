require 'chef/knife'
 
module Lnxchk
  class Pocket < Chef::Knife
 
    deps do
      require 'chef/mixin/command'
      require 'chef/search/query'
      require 'chef/knife/search'
      require 'chef/knife/ssh'
      require 'net/ssh/multi'
    end
 
    banner "knife pocket -P file --find 'QUERY' or knife pocket -P file --ssh 'COMMAND'"
  
    option :file,
      :short => '-P FILE',
      :long => '--pocket FILE',
      :boolean => false,
      :description => 'File to save data to' 
 
    def run
      what = name_args[0]
      @stuff = name_args[1]
 
      if config[:file]
        file = config[:file]
      else
        file = ".pocket"
      end
 
      if what == "find" 
        fuzzier_query = "tags:*#{@stuff}* OR roles:*#{@stuff}* OR fqdn:*#{@stuff}* OR addresses:*#{@stuff}*"
        knife_search = Chef::Knife::Search.new
#       knife_search.name_args = ['node', fuzzier_query, 'format', 'json']
        knife_search.name_args = ['node', fuzzier_query]
        save_list = knife_search.run
        fh = File.open(file, "w")
        save_list.each { |node|
          x = node["fqdn"]
          fh.write "#{x} ";
        }
      elsif what == "ssh"
        hosts = File.open(file, "r").read
        #print "knife ssh -m '#{hosts}' '#{@stuff}'\n";
        knife_ssh = Chef::Knife::Ssh.new
        cmd_line = @stuff
        knife_ssh.config[:manual] = true
        knife_ssh.name_args = [hosts, cmd_line]
        output = knife_ssh.run
      end
    end
  end
end

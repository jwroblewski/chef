#
# Author:: Adam Jacob (<adam@chef.io>)
# Copyright:: Copyright 2009-2016, Chef Software Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "chef/knife"

class Chef
  class Knife
    class RoleCreate < Knife

      deps do
        require "chef/role"
        require "chef/json_compat"
      end

      banner "knife role create ROLE (options)"

      option :description,
        short: "-d DESC",
        long: "--description DESC",
        description: "The role description."

      def run
        @role_name = @name_args[0]

        if @role_name.nil?
          show_usage
          ui.fatal("You must specify a role name")
          exit 1
        end

        role = Chef::Role.new
        role.name(@role_name)
        role.description(config[:description]) if config[:description]
        create_object(role, object_class: Chef::Role)
      end
    end
  end
end

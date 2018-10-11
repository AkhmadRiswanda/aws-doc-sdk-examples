#snippet-sourceauthor: [Doug-AWS]

#snippet-sourcedescription:[Description]

#snippet-service:[AWSService]

#snippet-sourcetype:[full example]

#snippet-sourcedate:[N/A]

# Copyright 2010-2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# This file is licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License. A copy of the
# License is located at
#
# http://aws.amazon.com/apache2.0/
#
# This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS
# OF ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

require 'aws-sdk-dynamodb'  # v2: require 'aws-sdk'
require 'json'

# Create dynamodb client in us-west-2 region
dynamodb = Aws::DynamoDB::Client.new(region: 'us-west-2')

file = File.read('movie_data.json')
movies = JSON.parse(file)
movies.each{|movie|

  params = {
      table_name: 'Movies',
      item: movie
  }

  begin
    result = dynamodb.put_item(params)
    puts 'Added movie: ' + {movie['year']}.to_i.to_s  + ' - ' + {movie['title']}

  rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts 'Unable to add movie:'
    puts error.message
  end
}

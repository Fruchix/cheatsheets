############################################################################
# Copyright 2025 Fruchix                                                   #
#                                                                          #
# Licensed under the Apache License, Version 2.0 (the "License");          #
# you may not use this file except in compliance with the License.         #
# You may obtain a copy of the License at                                  #
#                                                                          #
#     http://www.apache.org/licenses/LICENSE-2.0                           #
#                                                                          #
# Unless required by applicable law or agreed to in writing, software      #
# distributed under the License is distributed on an "AS IS" BASIS,        #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
# See the License for the specific language governing permissions and      #
# limitations under the License.                                           #
############################################################################

# KEYWORDS: sql sqlite foreign key cascade delete update

-- connect to DB
sqlite3 filename

-- $HOME/.sqliterc
.headers ON
.mode columns

-- https://stackoverflow.com/a/5901100
-- Foreign key support is not enabled in SQLite by default, enable it with:
PRAGMA foreign_keys = ON


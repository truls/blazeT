# Copyright Jasper Van der Jeugt 2010

# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.

#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.

#     * Neither the name of Jasper Van der Jeugt nor the names of other
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

################################################################################
# Configuration
################################################################################

GHC = cabal exec -- ghc
GHCI = ghci
GHC_FLAGS = -O2 -fforce-recomp -ibenchmarks -isrc -itests -fsimpl-tick-factor=200

BENCHMARK_FLAGS = --resamples 10000

################################################################################
# Benchmarks
################################################################################

benchmark:
	$(GHC) $(GHC_FLAGS) --make -main-is Benchmarks.RunHtmlBenchmarks src/Benchmarks/RunHtmlBenchmarks.hs
	./src/Benchmarks/RunHtmlBenchmarks $(BENCHMARK_FLAGS) -o report.html

benchmark-bigtable-non-haskell:
	ruby benchmarks/bigtable/erb.rb
	ruby benchmarks/bigtable/erubis.rb
	php -n benchmarks/bigtable/php.php


################################################################################
# generate combinators
################################################################################

combinators:
	runghc -isrc Util.GenerateHtmlTCombinators

combinators-stack:
	stack runghc --package regex-compat -- -isrc Util.GenerateHtmlTCombinators

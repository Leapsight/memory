% ==============================================================================
%  memory.erl
%  Copyright (c) 2016-2024 Leapsight. All rights reserved.
%
%  Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%  You may obtain a copy of the License at
%
%     http://www.apache.org/licenses/LICENSE-2.0
%
%  Unless required by applicable law or agreed to in writing, software
%  distributed under the License is distributed on an "AS IS" BASIS,
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%  See the License for the specific language governing permissions and
%  limitations under the License.
% ==============================================================================

%% -----------------------------------------------------------------------------
%% @doc This module provides utilities for working with memory size units in
%% both decimal (SI) and binary (IEC) formats.
%% It allows conversions between different units of measurement such as bytes,
%% kilobytes, megabytes, and their binary counterparts (kibibytes, mebibytes,
%% etc.), and formatting memory sizes in human-readable strings.
%%
%% The main functionalities include:
%%
%%  - Converting between units (e.g., kilobytes to bytes, mebibytes to bytes)
%%  - Formatting a memory size into human-readable strings in either decimal or
%%  binary units
%%  - Providing an easy API for common memory unit conversions
%%
%%  The module supports both decimal and binary units:
%%
%%  - **Decimal units**: byte, kilobyte, megabyte, gigabyte, terabyte
%%  - **Binary units**: byte, kibibyte, mebibyte, gibibyte, tebibyte
%% @end
%% -----------------------------------------------------------------------------
-module(memory).

-type unit()            ::  decimal_unit() | binary_unit().
-type unit_type()       ::  decimal | binary.
-type decimal_unit()    ::  byte
                            | kilobyte
                            | megabyte
                            | gigabyte
                            | terabyte.
-type binary_unit()     ::  byte
                            | kibibyte
                            | mebibyte
                            | gibibyte
                            | tebibyte.

-export([bytes/1]).
-export([convert/3]).
-export([format/2]).
-export([gibibytes/1]).
-export([gigabytes/1]).
-export([kibibytes/1]).
-export([kilobytes/1]).
-export([mebibytes/1]).
-export([megabytes/1]).
-export([tebibytes/1]).
-export([terabytes/1]).



% ==============================================================================
% API
% ==============================================================================



%% -----------------------------------------------------------------------------
%% @doc Returns the number of bytes in `N'.
%% This function handles the simplest case where `N' is already in bytes.
%% @end
%% -----------------------------------------------------------------------------
-spec bytes(non_neg_integer()) -> non_neg_integer().

bytes(N) when is_integer(N), N >= 0 ->
    N.


%% -----------------------------------------------------------------------------
%% @doc Converts kilobytes into bytes.
%% Returns the number of bytes in `N' kilobytes.
%% @end
%% -----------------------------------------------------------------------------
-spec kilobytes(number()) -> non_neg_integer().

kilobytes(N) when is_number(N), N >= 0 ->
    trunc(N * 1000).


%% -----------------------------------------------------------------------------
%% @doc Converts megabytes into bytes.
%% Returns the number of bytes in `N' megabytes.
%% @end
%% -----------------------------------------------------------------------------
-spec megabytes(number()) -> non_neg_integer().

megabytes(N) when is_number(N), N >= 0 ->
    trunc(N * 1000 * 1000).


%% -----------------------------------------------------------------------------
%% @doc Converts gigabytes into bytes.
%% Returns the number of bytes in `N' gigabytes.
%% @end
%% -----------------------------------------------------------------------------
-spec gigabytes(number()) -> non_neg_integer().

gigabytes(N) when is_number(N), N >= 0 ->
    trunc(N * 1000 * 1000 * 1000).


%% -----------------------------------------------------------------------------
%% @doc Converts terabytes into bytes.
%% Returns the number of bytes in `N' terabytes.
%% @end
%% -----------------------------------------------------------------------------
-spec terabytes(number()) -> non_neg_integer().

terabytes(N) when is_number(N), N >= 0 ->
    trunc(N * 1000 * 1000 * 1000 * 1000).


%% -----------------------------------------------------------------------------
%% @doc Converts kibibytes into bytes.
%% Returns the number of bytes in `N' kibibytes.
%% @end
%% -----------------------------------------------------------------------------
-spec kibibytes(number()) -> non_neg_integer().

kibibytes(N) when is_number(N), N >= 0 ->
    trunc(N * 1024).


%% -----------------------------------------------------------------------------
%% @doc Converts mebibytes into bytes.
%% Returns the number of bytes in `N' mebibytes.
%% @end
%% -----------------------------------------------------------------------------
-spec mebibytes(number()) -> non_neg_integer().

mebibytes(N) when is_number(N), N >= 0 ->
    trunc(N * 1024 * 1024).


%% -----------------------------------------------------------------------------
%% @doc Converts gibibytes into bytes.
%% Returns the number of bytes in `N' gibibytes.
%% @end
%% -----------------------------------------------------------------------------
-spec gibibytes(number()) -> non_neg_integer().

gibibytes(N) when is_number(N), N >= 0 ->
 trunc(N * 1024 * 1024 * 1024).


%% -----------------------------------------------------------------------------
%% @doc Converts tebibytes into bytes.
%% Returns the number of bytes in `N' tebibytes.
%% @end
%% -----------------------------------------------------------------------------
-spec tebibytes(number()) -> non_neg_integer().

tebibytes(N) when is_number(N), N >= 0 ->
    trunc(N * 1024 * 1024 * 1024 * 1024).

%% -----------------------------------------------------------------------------
%% @doc Convert `Value' from unit `FromUnit' to unit `ToUnit'.
%% Takes a numeric value and converts it from one unit of measurement to
%% another, calculating the number of bytes and then converting it back into the
%% desired unit.
%% @end
%% -----------------------------------------------------------------------------
-spec convert(number(), unit(), unit()) -> number().

convert(Value, FromUnit, ToUnit) when is_number(Value), Value >= 0 ->
    Bytes = to_bytes(Value, FromUnit),
    from_bytes(Bytes, ToUnit).

%% -----------------------------------------------------------------------------
%% @doc Returns a string representation of `Bytes' in the selected unit type.
%% The unit type can be either `decimal' or `binary'.
%% @end
%% -----------------------------------------------------------------------------
-spec format(non_neg_integer(), unit_type()) -> number().

format(Bytes, decimal) when is_number(Bytes), Bytes >= 0 ->
    case Bytes of
        _ when Bytes >= 1000 * 1000 * 1000 * 1000 ->
            io_lib:format("~p TB", [Bytes / (1000 * 1000 * 1000 * 1000)]);

        _ when Bytes >= 1000 * 1000 * 1000 ->
            io_lib:format("~p GB", [Bytes / (1000 * 1000 * 1000)]);

        _ when Bytes >= 1000 * 1000 ->
            io_lib:format("~p MB", [Bytes / (1000 * 1000)]);

        _ when Bytes >= 1000 ->
            io_lib:format("~p KB", [Bytes / 1000]);

        _ ->
            io_lib:format("~p bytes", [Bytes])
    end;

format(Bytes, binary) when is_number(Bytes), Bytes >= 0 ->
    case Bytes of
        _ when Bytes >= 1024 * 1024 * 1024 * 1024 ->
            io_lib:format("~p TiB", [Bytes / (1024 * 1024 * 1024 * 1024)]);

        _ when Bytes >= 1024 * 1024 * 1024 ->
            io_lib:format("~p GiB", [Bytes / (1024 * 1024 * 1024)]);

        _ when Bytes >= 1024 * 1024 ->
            io_lib:format("~p MiB", [Bytes / (1024 * 1024)]);

        _ when Bytes >= 1024 ->
            io_lib:format("~p KiB", [Bytes / 1024]);

        _ ->
            io_lib:format("~p bytes", [Bytes])
    end.



% ==============================================================================
% PRIVATE
% ==============================================================================



% Converts any unit to bytes
to_bytes(Value, byte)      -> Value;
to_bytes(Value, kilobyte)  -> kilobytes(Value);
to_bytes(Value, megabyte)  -> megabytes(Value);
to_bytes(Value, gigabyte)  -> gigabytes(Value);
to_bytes(Value, terabyte)  -> terabytes(Value);
to_bytes(Value, kibibyte)  -> kibibytes(Value);
to_bytes(Value, mebibyte)  -> mebibytes(Value);
to_bytes(Value, gibibyte)  -> gibibytes(Value);
to_bytes(Value, tebibyte)  -> tebibytes(Value).


% Converts bytes to the desired unit
from_bytes(Bytes, byte)      -> Bytes;
from_bytes(Bytes, kilobyte)  -> Bytes / 1000;
from_bytes(Bytes, megabyte)  -> Bytes / 1000000;
from_bytes(Bytes, gigabyte)  -> Bytes / 1000000000;
from_bytes(Bytes, terabyte)  -> Bytes / 1000000000000;
from_bytes(Bytes, kibibyte)  -> Bytes / 1024;
from_bytes(Bytes, mebibyte)  -> Bytes / (1024 * 1024);
from_bytes(Bytes, gibibyte)  -> Bytes / (1024 * 1024 * 1024);
from_bytes(Bytes, tebibyte)  -> Bytes / (1024 * 1024 * 1024 * 1024).
/*
License (MIT)

Copyright 2019 Mooshe
https://github.com/MoosheTV/redm-external

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

using System;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.Native;

namespace RedM.External
{
    public class Model : INativeValue, IEquatable<Model>
    {
        public int Hash { get; private set; }

        public Model()
        {

        }

        public Model(int hash) : this()
        {
            Hash = hash;
        }

        public Model(PedHash hash) : this((int)hash)
        {

        }

        public bool IsPed
        {
            get {
                var uHash = (uint)Hash;
                foreach (uint hash in Enum.GetValues(typeof(PedHash)))
                {
                    if (hash == uHash)
                    {
                        return true;
                    }
                }
                return false;
            }
        }

        public bool IsVehicle => API.IsModelAVehicle((uint)Hash);

        public Vector3 GetDimensions()
        {
            GetDimensions(out var right, out var left);
            return Vector3.Subtract(left, right);
        }

        public void GetDimensions(out Vector3 minimum, out Vector3 maximum)
        {
            Vector3 min = new Vector3();
            Vector3 max = new Vector3();

            API.GetModelDimensions((uint)Hash, ref min, ref max);

            minimum = min;
            maximum = max;
        }

        public void MarkAsNoLongerNeeded()
        {
            API.SetModelAsNoLongerNeeded((uint)Hash);
        }

        public bool Equals(Model other)
        {
            return Hash == other?.Hash;
        }

        public override bool Equals(object obj)
        {
            return obj != null && obj.GetType() == GetType() && Equals((Model)obj);
        }

        public override int GetHashCode()
        {
            return Hash.GetHashCode();
        }

        public override ulong NativeValue
        {
            get => (ulong)Hash;
            set => Hash = unchecked((int)value);
        }

        public static implicit operator Model(int source)
        {
            return new Model(source);
        }

        public static bool operator ==(Model left, Model right)
        {
            return left?.Equals(right) ?? false;
        }

        public static bool operator !=(Model left, Model right)
        {
            return !(left?.Equals(right) ?? false);
        }
    }
}

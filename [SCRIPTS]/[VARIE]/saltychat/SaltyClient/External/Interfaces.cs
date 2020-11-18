/*
License (MIT)

Copyright 2019 Mooshe
https://github.com/MoosheTV/redm-external

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

using System;
using CitizenFX.Core;
using CitizenFX.Core.Native;

namespace RedM.External
{
    public interface ISpatial
    {
        Vector3 Position { get; set; }
        Vector3 Rotation { get; set; }
    }

    public interface IExistable
    {
        bool Exists();
    }

    public interface IDeletable : IExistable
    {
        void Delete();
    }

    public abstract class PoolObject : INativeValue, IDeletable, IDisposable
    {
        protected PoolObject(int handle)
        {
            Handle = handle;
        }

        public int Handle { get; protected set; }
        public override ulong NativeValue
        {
            get { return (ulong)Handle; }
            set { Handle = unchecked((int)value); }
        }

        public abstract bool Exists();

        public abstract void Delete();

        public void Dispose()
        {
            Delete();
        }
    }
}

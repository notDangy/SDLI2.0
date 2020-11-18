/*
License (MIT)

Copyright 2019 Mooshe
https://github.com/MoosheTV/redm-external

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

using System;
using System.Security;
using CitizenFX.Core;
using CitizenFX.Core.Native;

namespace RedM.External
{
    public class Entity : PoolObject, IEquatable<Entity>, ISpatial
    {
        public Entity(int handle) : base(handle)
        {
        }

        public int Health
        {
            get => API.GetEntityHealth(Handle);
        }

        public bool IsDead => API.IsEntityDead(Handle);

        public bool IsAlive => !IsDead;

        public Model Model => new Model(API.GetEntityModel(Handle));

        public virtual Vector3 Position
        {
            get => API.GetEntityCoords(Handle, false, false);
            set => API.SetEntityCoords(Handle, value.X, value.Y, value.Z, false, false, false, true);
        }

        public Vector3 PositionNoOffset
        {
            set => API.SetEntityCoordsNoOffset(Handle, value.X, value.Y, value.Z, true, true, true);
        }

        public virtual Vector3 Rotation
        {
            get => API.GetEntityRotation(Handle, 0);
            set => API.SetEntityRotation(Handle, value.X, value.Y, value.Z, 2, true);
        }

        public float Heading
        {
            get => API.GetEntityHeading(Handle);
            set => API.SetEntityHeading(Handle, value);
        }

        public bool IsVisible
        {
            get => API.IsEntityVisible(Handle);
            set => API.SetEntityVisible(Handle, value);
        }

        public bool IsInvincible
        {
            set => API.SetEntityInvincible(Handle, value);
        }

        public EntityType EntityType => (EntityType)API.GetEntityType(Handle);

        public override bool Exists()
        {
            return API.DoesEntityExist(Handle);
        }

        [SecuritySafeCritical]
        public override void Delete()
        {
            _Delete();
        }

        [SecuritySafeCritical]
        private void _Delete()
        {
            // prevent the game from crashing if this is called on the player ped.
            if (Handle != Game.PlayerPed.Handle)
            {
                API.SetEntityAsMissionEntity(Handle, false, true);
                int handle = Handle;
                API.DeleteEntity(ref handle);
                Handle = handle;
            }
        }

        [SecuritySafeCritical]
        public void MarkAsNoLongerNeeded()
        {
            _MarkAsNoLongerNeeded();
        }

        [SecuritySafeCritical]
        private void _MarkAsNoLongerNeeded()
        {
            API.SetEntityAsMissionEntity(Handle, false, true);

            int handle = Handle;

            API.SetEntityAsNoLongerNeeded(ref handle);

            Handle = handle;
        }

        public static Entity FromNetworkId(int netId)
        {
            return FromHandle(API.NetworkGetEntityFromNetworkId(netId));
        }

        public static Entity FromHandle(int handle)
        {
            switch ((EntityType)API.GetEntityType(handle))
            {
                case EntityType.Ped:
                    return new Ped(handle);
                default:
                    return null;
            }
        }

        public bool Equals(Entity entity)
        {
            return !ReferenceEquals(entity, null) && Handle == entity.Handle;
        }
        public override bool Equals(object obj)
        {
            return !ReferenceEquals(obj, null) && obj.GetType() == GetType() && Equals((Entity)obj);
        }

        public override int GetHashCode()
        {
            return Handle.GetHashCode();
        }

        public static bool operator ==(Entity left, Entity right)
        {
            return left?.Equals(right) ?? ReferenceEquals(right, null);
        }
        public static bool operator !=(Entity left, Entity right)
        {
            return !(left == right);
        }
    }

    public enum EntityType
    {
        Ped = 1,
        Vehicle,
        Object
    }
}

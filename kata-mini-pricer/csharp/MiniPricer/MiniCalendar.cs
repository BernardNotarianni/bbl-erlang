using System;
using System.Collections.Generic;
using NUnit.Framework;

namespace MiniPricer
{
    public class MiniCalendar
    {
        private readonly List<DateTime> _bankHollidays = new List<DateTime>();

        public bool IsOpen(DateTime dateTime)
        {
            if (dateTime.DayOfWeek == DayOfWeek.Saturday) return false;
            if (dateTime.DayOfWeek == DayOfWeek.Sunday) return false;
            if (_bankHollidays.Contains(dateTime)) return false;
            return true;
        }

        public void AddBankHolliday(DateTime dateTime)
        {
            _bankHollidays.Add(dateTime);
        }

        public DateTime NextOpenDay(DateTime d)
        {
            var nextDay = d.AddDays(1);
            if (!IsOpen(nextDay)) return NextOpenDay(nextDay);
            return nextDay;
        }
    }
}
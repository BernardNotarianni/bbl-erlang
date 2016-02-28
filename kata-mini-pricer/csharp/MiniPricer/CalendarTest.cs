using System;
using NUnit.Framework;

namespace MiniPricer
{
    class CalendarTest
    {
        [Test]
        public void Regular_days_are_open ()
        {
            var calendar = new MiniCalendar();
            Assert.IsTrue(calendar.IsOpen(new DateTime(2014, 4, 8)));
        }

        [Test]
        public void Weekend_are_closed ()
        {
            var calendar = new MiniCalendar();
            Assert.IsTrue(calendar.IsOpen(new DateTime(2015, 4, 10)));
            Assert.IsFalse(calendar.IsOpen(new DateTime(2015, 4, 11)));
            Assert.IsFalse(calendar.IsOpen(new DateTime(2015, 4, 12)));
        }

        [Test]
        public void Bank_hollidays_are_closed ()
        {
            var calendar = new MiniCalendar();
            calendar.AddBankHolliday(new DateTime(2015, 4, 8));
            Assert.IsFalse(calendar.IsOpen(new DateTime(2015, 4, 8)));            
        }

        [Test]
        public void Compute_next_open_day()
        {
            var calendar = new MiniCalendar();
            Assert.AreEqual(new DateTime(2015,4,9), calendar.NextOpenDay(new DateTime(2015,4,8)));
        }

        [Test]
        public void Compute_next_open_day_over_weekend()
        {
            var calendar = new MiniCalendar();
            Assert.AreEqual(new DateTime(2015, 4, 13), calendar.NextOpenDay(new DateTime(2015, 4, 10)));
        }

        [Test]
        public void Compute_next_open_day_over_bank_holliday()
        {
            var calendar = new MiniCalendar();
            calendar.AddBankHolliday(new DateTime(2015, 4, 9));
            Assert.AreEqual(new DateTime(2015, 4, 10), calendar.NextOpenDay(new DateTime(2015, 4, 8)));
        }
    }
}

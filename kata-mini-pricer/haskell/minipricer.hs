module Main
where
import Test.Hspec
import Data.Time
import Data.Time.Calendar.WeekDate

priceWithHollidays :: [Day] -> Float -> Float -> Day -> Day -> Float
priceWithHollidays hollidays initialPrice volatility startDate priceDate
  | startDate == priceDate = initialPrice
  | otherwise =
      priceWithHollidays hollidays initialPrice volatility nextDate priceDate * (1 + volatility / 100)
      where nextDate = nextOpenDate hollidays startDate

price = priceWithHollidays []


nextOpenDate :: [Day] -> Day -> Day
nextOpenDate hollidays date =
  skipHollidays hollidays (addDays 1 date)

skipWeekEnd :: Day -> Day
skipWeekEnd date
  | weekDay == 6 = addDays 2 date
  | weekDay == 7 = addDays 1 date
  | otherwise = date
  where (_,_,weekDay) = toWeekDate date

skipHollidays :: [Day] -> Day -> Day
skipHollidays hollidays date
  | date `elem` hollidays = skipHollidays hollidays (addDays 1 date)
  | otherwise = skipWeekEnd date


d = fromGregorian 2015 05
wednesday  = d 13
thursday   = d 14
friday     = d 15
saturday   = d 16
sunday     = d 17
nextMonday = d 18

main :: IO()
main = hspec $ do

  describe "next open date" $ do

    it "should be next day" $ do
      nextOpenDate [] thursday `shouldBe` friday

    it "should skip weed-ends" $ do
      nextOpenDate [] friday `shouldBe` nextMonday
      nextOpenDate [] saturday `shouldBe` nextMonday
      nextOpenDate [] sunday `shouldBe` nextMonday

    it "should skip holliday" $ do
      nextOpenDate [thursday] wednesday `shouldBe` friday

  describe "pricing in future" $ do

    it "should be initialPrice at zero day" $ do
      price 100 10 thursday thursday `shouldBe` 100

    it "should price at one day" $ do
      price 100 10 thursday friday `shouldBe` 110

    it "should price at two days" $ do
      price 100 10 wednesday friday `shouldBe` 121

  describe "pricing over closed days" $ do

    it "should not consider saturday and sunday" $ do
      price 100 10 friday nextMonday `shouldBe` 110

    it "should not consider bank hollidays" $ do
      let hollidays = [thursday]
       in priceWithHollidays hollidays 100 10 wednesday friday `shouldBe` 110

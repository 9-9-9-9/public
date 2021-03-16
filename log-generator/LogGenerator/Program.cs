using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;

namespace LogGenerator
{
    internal static class Program
    {
        private const string LogPath =
#if DEBUG
                "/tmp/log"
#else
                "/root/log"
#endif
            ;

        private static readonly string AccessLogFilePath = $"{LogPath}/{LogType.Access}.log";
        private static readonly string AppLogFilePath = $"{LogPath}/{LogType.App}.log";
        private static readonly string BalanceAdjustmentLogFilePath = $"{LogPath}/{LogType.BalanceAdjustment}.log";
        private static readonly string RollingLogPath = $"{LogPath}/roll";
        private const string RollingLogFileName = "roll.log";
        private static readonly string RollingLogFilePath = $"{RollingLogPath}/{RollingLogFileName}";
        private static byte _rollingLogCounter = 1;
        private static ulong _rollingLogCounterVersion = 0;

        private static readonly string AppName =
            string.IsNullOrWhiteSpace(Environment.GetEnvironmentVariable("AppName"))
                ? "AppNameDefault"
                // ReSharper disable once PossibleNullReferenceException
                : Environment.GetEnvironmentVariable("AppName").Trim();

        internal static void Main()
        {
            if (!Directory.Exists(LogPath))
                Directory.CreateDirectory(LogPath);

            if (Directory.Exists(RollingLogPath))
            {
                Directory.Delete(RollingLogPath, true);
                Thread.Sleep(1_000);
            }

            if (!Directory.Exists(RollingLogPath))
                Directory.CreateDirectory(RollingLogPath);

            var interval = int.TryParse(Environment.GetEnvironmentVariable("SLEEP"), out var val)
                ? Math.Max(5, Math.Min(3600, val))
                : 5;
            
            while (true)
            {
                GenerateAccessLog();
                GenerateAppLog();
                GenerateBalanceAdjustmentLog();
                GenerateRollingLog();

                Thread.Sleep(interval * 1000);
            }

            // ReSharper disable once FunctionNeverReturns
        }

        private static void GenerateRollingLog()
        {
            var num = _rollingLogCounter++;
            
            //
            var sb = new StringBuilder();
            sb.Append(Now);
            sb.Append('\t');
            sb.Append(AppName);
            sb.Append('\t');
            sb.Append(GetRandomInstance());
            sb.Append('\t');
            sb.Append("test-rolling-log");
            sb.Append('\t');
            sb.Append(GetRandomLogLevel(NormalLogLevels));
            sb.Append('\t');
            sb.Append(num.ToString());
            sb.Append('\n');
            //
            
            File.AppendAllText(RollingLogFilePath, sb.ToString());
            if (num % 5 != 0)
                return;
            File.Move(RollingLogFilePath, $"{RollingLogFilePath}.{++_rollingLogCounterVersion}");
        }

        private static readonly LogLevel[] NormalLogLevels =
        {
            LogLevel.Debug,
            LogLevel.Info,
            LogLevel.Warn,
        };

        private static readonly string[] UserName =
        {
            // ReSharper disable StringLiteralTypo
            "jelly",
            "diana",
            "yummy",
            // ReSharper restore StringLiteralTypo
        };

        private static readonly string[] HttpMethods =
        {
            // ReSharper disable StringLiteralTypo
            "GET",
            "POST",
            "DELETE",
            // ReSharper restore StringLiteralTypo
        };

        private static readonly string[] ApiEndpoints =
        {
            // ReSharper disable StringLiteralTypo
            "/employees",
            "/balance/deposite",
            "/balance/withdraw",
            "/audit",
            "/roles",
            // ReSharper restore StringLiteralTypo
        };

        private static void GenerateAccessLog()
        {
            var sb = new StringBuilder();
            sb.Append(Now);
            sb.Append('\t');
            sb.Append(AppName);
            sb.Append('\t');
            sb.Append(GetRandomInstance());
            sb.Append('\t');
            sb.Append("access-log");
            sb.Append('\t');
            sb.Append(GetRandomLogLevel(NormalLogLevels));
            sb.Append('\t');
            sb.Append($"{GetRandomString(HttpMethods)} {GetRandomString(ApiEndpoints)} by {GetRandomString(UserName)}");
            sb.Append('\n');

            File.AppendAllText(AccessLogFilePath, sb.ToString());
        }

        private static readonly LogLevel[] LogLevelsOfError =
        {
            LogLevel.Error,
            LogLevel.Fatal,
            LogLevel.Error,
            LogLevel.Fatal,
            LogLevel.Warn,
        };

        private static void GenerateAppLog()
        {
            var sb = new StringBuilder();
            sb.Append(Now);
            sb.Append('\t');
            sb.Append(AppName);
            sb.Append('\t');
            sb.Append(GetRandomInstance());
            sb.Append('\t');
            sb.Append("application-log");
            sb.Append('\t');
            sb.Append(GetRandomJavaClassName());
            sb.Append('\t');

            string[] lines;

            var rad = Rad.Next(int.MinValue, int.MaxValue);
            var div = 5;
            if (rad % div == 0)
            {
                sb.Append(GetRandomLogLevel(LogLevelsOfError));
                try
                {
                    if (rad % 3 == 0)
                        throw new ArgumentException(
                            $"Invalid argument {GetRandomString(new[] {nameof(sb), nameof(rad), nameof(div)})}");
                    if (rad % 3 == 1)
                        throw new IndexOutOfRangeException($"Array contains less than {Rad.Next(3, 10)} elements");
                    // ReSharper disable once StringLiteralTypo
                    throw new Exception($"Lorem ip sum {rad}");
                }
                catch (Exception e)
                {
                    lines = ConvertToMultiline(sb.ToString(), e.ToString().Split('\n')).ToArray();
                }
            }
            else
            {
                sb.Append(GetRandomLogLevel(NormalLogLevels));
                lines = new string[Rad.Next(1, 4)];
                for (var i = 0; i < lines.Length; i++)
                    lines[i] = $"{i}-{Math.Abs(rad)}-{Rad.Next(byte.MinValue, byte.MaxValue)}";
                lines = ConvertToMultiline(sb.ToString(), lines).ToArray();
            }

            File.AppendAllLines(AppLogFilePath, lines);
        }

        private static void GenerateBalanceAdjustmentLog()
        {
            var sb = new StringBuilder();
            sb.Append(Now);
            sb.Append('\t');
            sb.Append(AppName);
            sb.Append('\t');
            sb.Append(GetRandomInstance());
            sb.Append('\t');
            sb.Append("balance-adjustment-log");
            sb.Append('\t');
            sb.Append(GetRandomJavaClassName());
            sb.Append('\t');
            sb.Append(GetRandomLogLevel(NormalLogLevels));

            var rad = Rad.Next(byte.MinValue, byte.MaxValue);
            string actName;
            bool success;
            var previousBalance = Rad.Next(10_000_000, 100_000_000);
            int amt;
            long currentBalance;
            if (rad % 2 == 0)
            {
                actName = "DEPOSIT (+)";
                amt = Rad.Next(1, 1_000_000_000);
                currentBalance = previousBalance + amt;
                success = true;
            }
            else
            {
                actName = "WITHDRAW (-)";
                amt = Rad.Next(0, 10) % 5 == 1
                    ? (previousBalance + Rad.Next(1_000, 10_000_000))
                    : Rad.Next(1_000, previousBalance);
                currentBalance = previousBalance - amt;
                if (currentBalance < 50_000)
                {
                    currentBalance = previousBalance;
                    success = false;
                }
                else
                {
                    success = true;
                }
            }

            File.AppendAllLines(BalanceAdjustmentLogFilePath, ConvertToMultiline(sb.ToString(), new[]
            {
                $"{GetRandomString(UserName)} {actName} {amt}",
                $"TxId: {Guid.NewGuid()}",
                $"Secret: PrivateKey-{Guid.NewGuid()}",
                $"Amount: {amt}",
                $"Success: {success}",
                $"Previous balance: {previousBalance}",
                $"Current balance: {currentBalance}{(success ? string.Empty : " (no change)")}",
            }));
        }

        private static readonly Random Rad = new Random(1992);
        private static string GetRandomInstance() => $"ins-{Rad.Next(1, 5)}";

        private static string GetRandomLogLevel(IReadOnlyList<LogLevel> logLevels) =>
            logLevels[Rad.Next(0, logLevels.Count)].LogLevelToString();

        private static string GetRandomString(IReadOnlyList<string> candidates) =>
            candidates[Rad.Next(0, candidates.Count)];

        private static string GetRandomJavaClassName() => $"com.test.package{Rad.Next(1, 5)}.Class{Rad.Next(5, 9)}";

        private enum LogType
        {
            Access,
            App,
            BalanceAdjustment,
        }

        private enum LogLevel
        {
            Debug,
            Info,
            Warn,
            Error,
            Fatal
        }

        private static IEnumerable<string> ConvertToMultiline(string firstLinePrefix, IEnumerable<string> lines)
        {
            var first = true;

            foreach (var line in lines)
            {
                if (first)
                {
                    first = false;
                    yield return $"{firstLinePrefix.Trim()}\t{line}";
                }
                else
                    yield return $"\t\t-\t{line}";
            }
        }

        private static string Now => $"{DateTime.UtcNow.AddHours(7):yyyy-MM-dd HH:mm:ss.FFFFFFF}";

        private static string LogLevelToString(this LogLevel logLevel) => logLevel.ToString().ToUpperInvariant();
    }
}
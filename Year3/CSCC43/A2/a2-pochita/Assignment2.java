import java.sql.*;
import java.util.Properties;

public class Assignment2 {


	public Connection connection;


	public Assignment2() {

	}

	/// Helpers
	public int[] getLatestPlayerRatingDate() throws SQLException {
		PreparedStatement st = connection.prepareStatement(
				"SELECT year, month " +
						"FROM A2.PlayerRatings " +
						"ORDER BY year desc, month desc " +
						"FETCH NEXT 1 ROWS ONLY"
		);

		ResultSet rs = st.executeQuery();
		int[] res = new int[2];

		if (rs.next()) {
			res[0] = rs.getInt("year");
			res[1] = rs.getInt("month");
		}
		else {
			throw new SQLException();
		}

		return res;
	}

	////////////////////////////////////////
	/// DELETE THIS AFTER TESTING
	////////////////////////////////////////
//	 public static void main(String[] args) {
//	 Assignment2 a2 = new Assignment2();
//		 System.out.println(a2.connectDB("jdbc:postgresql://localhost/postgres", "username", "password"));
//
//		 System.out.println("Get guild1 player count: " + a2.getMembersCount(1));
//		 System.out.println("Insert player5: " + a2.insertPlayer(5, "player5", "player5@email.com", "AUS"));
//
//		 System.out.println("Get player info: " + a2.getPlayerInfo(1));
//		 System.out.println("Get player info non-existent: " + a2.getPlayerInfo(9237132));
//
//		 System.out.println("Change guild1 name to modifiedguild1: " + a2.changeGuild("guild1", "modifiedguild1"));
//		 System.out.println("Change modifiedguild1 name to guild1: " + a2.changeGuild("modifiedguild1", "guild1"));
//
//		 System.out.println("Change nonexistant guild name: " + a2.changeGuild("nonexistant", "new"));
//
//		 System.out.println("Get all player ratings: " + a2.listAllTimePlayerRatings());
//
//		 System.out.println("Test update monthly ratings: " + a2.updateMonthlyRatings());
//
//		 System.out.println("Delete guild: " + a2.deleteGuild("orion"));
//
//		 System.out.println("Test create squid table: " + a2.createSquidTable());
//
//		 System.out.println("Test delete squid table: " + a2.deleteSquidTable());
//
//		 System.out.println(a2.disconnectDB());
//	 }


	public boolean connectDB(String URL, String username, String password) {
		Properties properties = new Properties();
		properties.setProperty("user", username);
		properties.setProperty("password", password);

		try {
			connection = DriverManager.getConnection(URL, properties);
			return true;
		} catch (SQLException e) {
			return false;
		}
	}


	public boolean disconnectDB() {
		if (connection != null) {
			try {
				connection.close();
				return true;
			} catch (SQLException e) {
				return false;
			}
		}
		return false;
	}


	public boolean insertPlayer(int id, String playerName, String email, String countryCode) {
		if (!countryCode.matches("[A-Z]{3}")) return false;

		try {
			PreparedStatement check = connection.prepareStatement("SELECT * FROM A2.Player WHERE id = ? OR playername = ? OR email = ?");
			check.setInt(1, id);
			check.setString(2, playerName);
			check.setString(3, email);

			ResultSet rs = check.executeQuery();
			if (rs.next()) return false;
			check.close();

			PreparedStatement st = connection.prepareStatement(
					"INSERT INTO A2.Player VALUES (?, ?, ?, ?)"
			);
			st.setInt(1, id);
			st.setString(2, playerName);
			st.setString(3, email);
			st.setString(4, countryCode);

			int rows = st.executeUpdate();
			st.close();
			return rows == 1;
		} catch (SQLException e) {
			System.err.println(e);
			return false;
		}
	}


	public int getMembersCount(int gid) {
		try {
			PreparedStatement st = connection.prepareStatement(
					"SELECT count(p.id) " +
							"FROM A2.Guild g JOIN A2.Player p ON p.guild = g.id " +
							"WHERE g.id = ?"
			);
			st.setInt(1, gid);

			ResultSet rs = st.executeQuery();
			int res = -1;
			if (rs.next()) {
				res = rs.getInt(1);
			}

			st.close();
			return res;
		} catch (SQLException e) {
			System.err.println(e);
			return -1;
		}
	}


	public String getPlayerInfo(int id) {
		try {
			PreparedStatement st = connection.prepareStatement(
					"SELECT * FROM A2.Player WHERE id = ?"
			);
			st.setInt(1, id);

			ResultSet rs = st.executeQuery();

			String res = "";
			if (rs.next()) {
				res = rs.getString("id") + ":" +
						rs.getString("playername") + ":" +
						rs.getString("email") + ":" +
						rs.getString("country_code") + ":" +
						rs.getInt("coins") + ":" +
						rs.getInt("wins") + ":" +
						rs.getInt("losses") + ":" +
						rs.getInt("total_battles") + ":" +
						rs.getInt("guild");
			}

			st.close();
			return res;
		} catch (SQLException e) {
			return "";
		}
	}


	public boolean changeGuild(String oldName, String newName) {
		try {
			PreparedStatement st = connection.prepareStatement(
					"UPDATE A2.Guild " +
							"SET guildname = ? " +
							"WHERE guildname = ?"
			);
			st.setString(1, newName);
			st.setString(2, oldName);

			int rows = st.executeUpdate();
			st.close();
			return rows == 1;
		} catch (SQLException e) {
			System.err.println(e);
			return false;
		}
	}


	public boolean deleteGuild(String guildName) {
		try {
			PreparedStatement st = connection.prepareStatement("SELECT id FROM A2.Guild WHERE guildname = ?");
			st.setString(1, guildName);
			ResultSet rs = st.executeQuery();
			int id = -1;
			if (rs.next()) {
				id = rs.getInt(1);
				st.close();
			}
			else {
				st.close();
				return false;
			}

			st = connection.prepareStatement(
					"DELETE FROM A2.GuildRatings " +
							"WHERE g_id = ?"
			);
			st.setInt(1, id);
			st.executeUpdate();
			st.close();

			st = connection.prepareStatement(
					"DELETE FROM A2.Guild " +
							"WHERE guildname = ?"
			);
			st.setString(1, guildName);

			int rows = st.executeUpdate();
			st.close();
			return rows == 1;
		} catch (SQLException e) {
			System.err.println(e);
			return false;
		}
	}


	public String listAllTimePlayerRatings() {
		try {
			PreparedStatement st = connection.prepareStatement(
					"SELECT playername, all_time_rating " +
							"FROM A2.Player p JOIN A2.PlayerRatings pr ON pr.p_id = p.id " +
							"WHERE pr.year = ? AND pr.month = ?"
			);
			int[] latestDate = getLatestPlayerRatingDate();
			st.setInt(1, latestDate[0]);
			st.setInt(2, latestDate[1]);

			ResultSet rs = st.executeQuery();

			StringBuilder res = new StringBuilder();
			while (rs.next()) {
				if (res.length() > 0) res.append(":");
				res.append(rs.getString("playername")).append(":").append(rs.getString("all_time_rating"));
			}

			st.close();
			return res.toString();
		} catch (SQLException e) {
			return "";
		}
	}


	public boolean updateMonthlyRatings() {
		try {
			PreparedStatement st = connection.prepareStatement(
					"INSERT INTO A2.PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) " +
							"(SELECT DISTINCT ON (p.id) p.id as p_id, 10 as month, 2022 as year, coalesce(monthly_rating * 1.1, 1000) as monthly_rating, coalesce(all_time_rating * 1.1, 1000) as all_time_rating " +
							"FROM A2.Player p LEFT JOIN A2.PlayerRatings pr ON p.id = pr.p_id AND month = 9 AND year = 2022)"
			);

			int rows = st.executeUpdate();
			st.close();

			ResultSet check_rs = connection.prepareStatement("SELECT count(*) FROM A2.Player").executeQuery();
			check_rs.next();
			int count = check_rs.getInt(1);
			if (rows != count) return false;

			st = connection.prepareStatement(
					"INSERT INTO A2.GuildRatings (g_id, month, year, monthly_rating, all_time_rating) " +
							"(SELECT DISTINCT ON (g.id) g.id as g_id, 10 as month, 2022 as year, coalesce(monthly_rating * 1.1, 1000) as monthly_rating, coalesce(all_time_rating * 1.1, 1000) as all_time_rating " +
							"FROM A2.Guild g LEFT JOIN A2.GuildRatings gr ON g.id = gr.g_id AND month = 9 AND year = 2022)"
			);
			rows = st.executeUpdate();

			check_rs = connection.prepareStatement("SELECT count(*) FROM A2.Guild").executeQuery();
			check_rs.next();
			count = check_rs.getInt(1);
			st.close();

			return rows == count;
		} catch (SQLException e) {
			System.err.println(e);
			return false;
		}
	}


	public boolean createSquidTable() {
		try {
			PreparedStatement st = connection.prepareStatement(
					"CREATE TABLE A2.squidNation(" +
							"id INTEGER," +
							"playername VARCHAR," +
							"email VARCHAR," +
							"coins INTEGER," +
							"rolls INTEGER," +
							"wins INTEGER," +
							"losses INTEGER," +
							"total_battles INTEGER" +
							")"
			);

			st.executeUpdate();
			st.close();

			st = connection.prepareStatement(
					"INSERT INTO A2.squidNation\n" +
							"(SELECT p.id as id, playername, email, coins, rolls, wins, losses, total_battles " +
							"FROM A2.Player p JOIN A2.Guild g ON p.guild = g.id " +
							"WHERE g.guildname = 'Squid Game' AND p.country_code = 'KOR' " +
							"ORDER BY p.id)"
			);
			int rows = st.executeUpdate();
			st.close();

			ResultSet check_rs = connection.prepareStatement(
					"SELECT count(p.id)" +
							"FROM A2.Player p JOIN A2.Guild g ON p.guild = g.id " +
							"WHERE g.guildname = 'Squid Game' AND p.country_code = 'KOR'"
			).executeQuery();
			check_rs.next();
			int count = check_rs.getInt(1);

			return rows == count;
		} catch (SQLException e) {
			System.err.println(e);
			return false;
		}
	}
	
	
	public boolean deleteSquidTable() {
		try {
			PreparedStatement st = connection.prepareStatement(
					"DROP TABLE A2.squidNation"
			);

			st.executeUpdate();
			st.close();

			return true;
		} catch (SQLException e) {
			System.err.println(e);
			return false;
		}
	}
}

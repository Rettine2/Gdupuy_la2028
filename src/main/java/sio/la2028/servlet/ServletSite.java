package sio.la2028.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import sio.la2028.database.DaoSite;
import sio.la2028.model.Site;

public class ServletSite extends HttpServlet {

    Connection cnx;

    @Override
    public void init() {
        ServletContext servletContext = getServletContext();
        cnx = (Connection) servletContext.getAttribute("connection");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = request.getRequestURI();

        if (url.equals("/la2028/ServletSite/lister")) {
            ArrayList<Site> lesSites = DaoSite.getLesSites(cnx);
            request.setAttribute("pLesSites", lesSites);
            getServletContext().getRequestDispatcher("/vues/site/listerSites.jsp").forward(request, response);
        }
        else if (url.equals("/la2028/ServletSite/consulter")) {
            int idSite = Integer.parseInt(request.getParameter("idSite"));
            Site s = DaoSite.getSiteById(cnx, idSite);
            request.setAttribute("pSite", s);
            getServletContext().getRequestDispatcher("/vues/site/consulterSite.jsp").forward(request, response);
        }
    }
}